import 'package:dartz/dartz.dart';
import 'package:fahem_business/core/network/api_constants.dart';
import 'package:fahem_business/data/models/main_category_model.dart';
import 'package:flutter/material.dart';
import 'package:fahem_business/core/error/failure.dart';
import 'package:fahem_business/core/resources/strings_manager.dart';
import 'package:fahem_business/core/utilities/dependency_injection.dart';
import 'package:fahem_business/core/utilities/dialogs.dart';
import 'package:fahem_business/core/utilities/enums.dart';
import 'package:fahem_business/core/utilities/extensions.dart';
import 'package:fahem_business/core/utilities/methods.dart';
import 'package:fahem_business/data/models/service_model.dart';
import 'package:fahem_business/domain/usecases/services/edit_service_usecase.dart';
import 'package:fahem_business/domain/usecases/services/insert_service_usecase.dart';
import 'package:image_picker/image_picker.dart';

class InsertEditServiceProvider with ChangeNotifier {

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

  dynamic _serviceImage;
  dynamic get serviceImage => _serviceImage;
  setServiceImage(dynamic serviceImage) => _serviceImage = serviceImage;
  changeServiceImage(dynamic serviceImage) {_serviceImage = serviceImage; notifyListeners();}

  dynamic _additionalImage;
  dynamic get additionalImage => _additionalImage;
  setAdditionalImage(dynamic additionalImage) => _additionalImage = additionalImage;
  changeAdditionalImage(dynamic additionalImage) {_additionalImage = additionalImage; notifyListeners();}

  MainCategoryModel? _mainCategory;
  MainCategoryModel? get mainCategory => _mainCategory;
  setMainCategory(MainCategoryModel? mainCategory) => _mainCategory = mainCategory;
  changeMainCategory(MainCategoryModel? mainCategory) {_mainCategory = mainCategory; notifyListeners();}

  bool _availableForAccount = false;
  bool get availableForAccount => _availableForAccount;
  setAvailableForAccount(bool availableForAccount) => _availableForAccount = availableForAccount;
  changeAvailableForAccount(bool availableForAccount) {_availableForAccount = availableForAccount; notifyListeners();}

  bool _serviceProviderCanSubscribe = false;
  bool get serviceProviderCanSubscribe => _serviceProviderCanSubscribe;
  setServiceProviderCanSubscribe(bool serviceProviderCanSubscribe) => _serviceProviderCanSubscribe = serviceProviderCanSubscribe;
  changeServiceProviderCanSubscribe(bool serviceProviderCanSubscribe) {_serviceProviderCanSubscribe = serviceProviderCanSubscribe; notifyListeners();}

  bool isAllDataValid() {
    if(_serviceImage == null) {
      Methods.showToast(message: Methods.getText(StringsManager.imageIsRequired).toCapitalized());
      return false;
    }
    if(_additionalImage == null) {
      Methods.showToast(message: Methods.getText(StringsManager.imageIsRequired).toCapitalized());
      return false;
    }
    if(_mainCategory == null) {
      Methods.showToast(message: Methods.getText(StringsManager.chooseMainCategory).toCapitalized());
      return false;
    }
    return true;
  }

  // region Insert And Edit Service
  Future<void> insertService({required BuildContext context, required InsertServiceParameters insertServiceParameters}) async {
    changeIsLoading(true);
    if(_serviceImage is XFile) {
      String? imageName = await Methods.uploadImage(context: context, imagePath: _serviceImage.path!, directory: ApiConstants.servicesDirectory);
      insertServiceParameters.serviceImage = imageName!;
    }
    if(_additionalImage is XFile) {
      String? imageName = await Methods.uploadImage(context: context, imagePath: _additionalImage.path!, directory: ApiConstants.servicesDirectory);
      insertServiceParameters.additionalImage = imageName!;
    }
    Either<Failure, ServiceModel> response = await DependencyInjection.insertServiceUseCase.call(insertServiceParameters);
    await response.fold((failure) async {
      changeIsLoading(false);
      await Dialogs.failureOccurred(context: context, failure: failure);
    }, (service) async {
      changeIsLoading(false);
      Dialogs.showBottomSheetMessage(
        context: context,
        message: Methods.getText(StringsManager.addedSuccessfully).toTitleCase(),
        showMessage: ShowMessage.success,
        thenMethod: () => Navigator.pop(context, service),
      );
    });
  }

  Future<void> editService({required BuildContext context, required EditServiceParameters editServiceParameters}) async {
    changeIsLoading(true);
    if(_serviceImage is XFile) {
      String? imageName = await Methods.uploadImage(context: context, imagePath: _serviceImage.path!, directory: ApiConstants.servicesDirectory);
      editServiceParameters.serviceImage = imageName!;
    }
    if(_additionalImage is XFile) {
      String? imageName = await Methods.uploadImage(context: context, imagePath: _additionalImage.path!, directory: ApiConstants.servicesDirectory);
      editServiceParameters.additionalImage = imageName!;
    }
    Either<Failure, ServiceModel> response = await DependencyInjection.editServiceUseCase.call(editServiceParameters);
    await response.fold((failure) async {
      changeIsLoading(false);
      await Dialogs.failureOccurred(context: context, failure: failure);
    }, (service) async {
      changeIsLoading(false);
      Dialogs.showBottomSheetMessage(
        context: context,
        message: Methods.getText(StringsManager.modifiedSuccessfully).toTitleCase(),
        showMessage: ShowMessage.success,
        thenMethod: () => Navigator.pop(context, service),
      );
    });
  }
  // endregion
}