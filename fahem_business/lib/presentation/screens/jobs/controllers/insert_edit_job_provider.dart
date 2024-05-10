import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:fahem_business/core/error/failure.dart';
import 'package:fahem_business/core/network/api_constants.dart';
import 'package:fahem_business/core/resources/strings_manager.dart';
import 'package:fahem_business/core/utilities/dependency_injection.dart';
import 'package:fahem_business/core/utilities/dialogs.dart';
import 'package:fahem_business/core/utilities/enums.dart';
import 'package:fahem_business/core/utilities/extensions.dart';
import 'package:fahem_business/core/utilities/methods.dart';
import 'package:fahem_business/data/models/job_model.dart';
import 'package:fahem_business/domain/usecases/jobs/edit_job_usecase.dart';
import 'package:fahem_business/domain/usecases/jobs/insert_job_usecase.dart';

class InsertEditJobProvider with ChangeNotifier {

  bool _isScreenDisposed = false;
  bool get isScreenDisposed => _isScreenDisposed;
  setIsScreenDisposed(bool isScreenDisposed) => _isScreenDisposed = isScreenDisposed;

  bool _isLoading = false;
  bool get isLoading => _isLoading;
  changeIsLoading(bool isLoading) {_isLoading = isLoading; notifyListeners();}

  bool _isButtonClicked = false;
  bool get isButtonClicked => _isButtonClicked;
  setIsButtonClicked(bool isButtonClicked) => _isButtonClicked = isButtonClicked;
  changeIsButtonClicked(bool isButtonClicked) {_isButtonClicked = isButtonClicked; notifyListeners();}

  dynamic _jobImage;
  dynamic get jobImage => _jobImage;
  setJobImage(dynamic jobImage) => _jobImage = jobImage;
  changeJobImage(dynamic jobImage) {_jobImage = jobImage; notifyListeners();}

  List<String> _features = [];
  List<String> get features => _features;
  setFeatures(List<String> features) => _features = features;
  changeFeatures(List<String> features) {_features = features; notifyListeners();}
  addInFeatures(String task) {
    if(!_features.contains(task) && task.isNotEmpty) {
      _features.add(task);
      notifyListeners();
    }
  }
  removeFromFeatures(String task) {
    _features.removeWhere((element) => element == task);
    notifyListeners();
  }

  bool _isAvailable = false;
  bool get isAvailable => _isAvailable;
  setIsAvailable(bool isAvailable) => _isAvailable = isAvailable;
  changeIsAvailable(bool isAvailable) {_isAvailable = isAvailable; notifyListeners();}

  bool isAllDataValid() {
    if(_jobImage == null) {
      Methods.showToast(message: Methods.getText(StringsManager.jobImageIsRequired).toCapitalized());
      return false;
    }
    if(_features.isEmpty) {
      Methods.showToast(message: Methods.getText(StringsManager.featuresRequired).toCapitalized());
      return false;
    }
    return true;
  }

  // region Insert And Edit Job
  Future<void> insertJob({required BuildContext context, required InsertJobParameters insertJobParameters}) async {
    changeIsLoading(true);
    if(_jobImage is XFile) {
      String? imageName = await Methods.uploadImage(context: context, imagePath: _jobImage.path!, directory: ApiConstants.jobsDirectory);
      insertJobParameters.image = imageName!;
    }
    Either<Failure, JobModel> response = await DependencyInjection.insertJobUseCase.call(insertJobParameters);
    await response.fold((failure) async {
      changeIsLoading(false);
      await Dialogs.failureOccurred(context: context, failure: failure);
    }, (job) async {
      changeIsLoading(false);
      Dialogs.showBottomSheetMessage(
        context: context,
        message: Methods.getText(StringsManager.addedSuccessfully).toTitleCase(),
        showMessage: ShowMessage.success,
        thenMethod: () => Navigator.pop(context, job),
      );
    });
  }

  Future<void> editJob({required BuildContext context, required EditJobParameters editJobParameters}) async {
    changeIsLoading(true);
    if(_jobImage is XFile) {
      String? imageName = await Methods.uploadImage(context: context, imagePath: _jobImage.path!, directory: ApiConstants.jobsDirectory);
      editJobParameters.image = imageName!;
    }
    Either<Failure, JobModel> response = await DependencyInjection.editJobUseCase.call(editJobParameters);
    await response.fold((failure) async {
      changeIsLoading(false);
      await Dialogs.failureOccurred(context: context, failure: failure);
    }, (job) async {
      changeIsLoading(false);
      Dialogs.showBottomSheetMessage(
        context: context,
        message: Methods.getText(StringsManager.modifiedSuccessfully).toTitleCase(),
        showMessage: ShowMessage.success,
        thenMethod: () => Navigator.pop(context, job),
      );
    });
  }
  // endregion
}