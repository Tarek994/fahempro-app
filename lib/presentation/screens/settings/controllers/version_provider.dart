import 'package:dartz/dartz.dart';
import 'package:fahem/core/network/firebase_constants.dart';
import 'package:fahem/core/resources/strings_manager.dart';
import 'package:fahem/core/services/notification_service.dart';
import 'package:fahem/core/utilities/dialogs.dart';
import 'package:fahem/core/utilities/extensions.dart';
import 'package:fahem/domain/usecases/version/edit_version_usecase.dart';
import 'package:flutter/material.dart';
import 'package:fahem/core/error/failure.dart';
import 'package:fahem/core/utilities/dependency_injection.dart';
import 'package:fahem/core/utilities/enums.dart';
import 'package:fahem/core/utilities/methods.dart';
import 'package:fahem/data/models/version_model.dart';
import 'package:fahem/domain/usecases/version/get_version_usecase.dart';

class VersionProvider with ChangeNotifier {

  // region Get Version
  late VersionModel _versionModel;
  VersionModel get versionModel => _versionModel;
  setVersionModel(VersionModel versionModel) => _versionModel = versionModel;
  editVersionModel(VersionModel versionModel) {_versionModel = versionModel; notifyListeners();}

  DataState _dataState = DataState.loading;
  DataState get dataState => _dataState;
  setDataState(DataState dataState) => _dataState = dataState;
  changeDataState(DataState dataState) {_dataState = dataState; notifyListeners();}

  bool _isScreenDisposed = false;
  bool get isScreenDisposed => _isScreenDisposed;
  setIsScreenDisposed(bool isScreenDisposed) => _isScreenDisposed = isScreenDisposed;

  Future<void> fetchData({required App app}) async {
    changeDataState(DataState.loading);
    Either<Failure, VersionModel> response = await DependencyInjection.getVersionUseCase.call(GetVersionParameters(app: app));
    if(isScreenDisposed) return;
    response.fold((failure) async {
      Methods.showToast(failure: failure);
      changeDataState(DataState.error);
    }, (version) async {
      setVersionModel(version);
      changeDataState(DataState.done);
    });
  }

  void _resetVariablesToDefault() {
    setDataState(DataState.loading);
    setIsScreenDisposed(false);
  }

  Future<void> reFetchData({required App app}) async {
    if(_dataState == DataState.loading) return;
    _resetVariablesToDefault();
    await fetchData(app: app);
  }
  // endregion

  // region Edit Version
  bool _isLoading = false;
  bool get isLoading => _isLoading;
  changeIsLoading(bool isLoading) {_isLoading = isLoading; notifyListeners();}

  Future<void> editVersion({required BuildContext context, required EditVersionParameters parameters}) async {
    changeIsLoading(true);
    Either<Failure, VersionModel> response = await DependencyInjection.editVersionUseCase.call(parameters);
    response.fold((failure) async {
      changeIsLoading(false);
      await Dialogs.failureOccurred(context: context, failure: failure);
    }, (version) async {
      changeIsLoading(false);
      Dialogs.showBottomSheetMessage(
        context: context,
        message: Methods.getText(StringsManager.modifiedSuccessfully).toTitleCase(),
        showMessage: ShowMessage.success,
        thenMethod: () => Navigator.pop(context, version),
      );
      NotificationService.pushNotification(
        topic: FirebaseConstants.fahemTopic,
        title: 'تحديث التطبيق',
        body: 'قم بتحديث التطبيق الآن للاستفادة من جميع الميزات',
        data: {
          'action': FirebaseConstants.updateApp,
        },
      );
    });
  }
  // endregion
}