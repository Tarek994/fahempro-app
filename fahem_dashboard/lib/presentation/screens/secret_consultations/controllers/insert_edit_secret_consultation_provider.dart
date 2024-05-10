import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:fahem_dashboard/core/network/api_constants.dart';
import 'package:fahem_dashboard/core/resources/constants_manager.dart';
import 'package:fahem_dashboard/data/models/user_model.dart';
import 'package:fahem_dashboard/domain/usecases/upload_file/upload_file_usecase.dart';
import 'package:flutter/material.dart';
import 'package:fahem_dashboard/core/error/failure.dart';
import 'package:fahem_dashboard/core/resources/strings_manager.dart';
import 'package:fahem_dashboard/core/utilities/dependency_injection.dart';
import 'package:fahem_dashboard/core/utilities/dialogs.dart';
import 'package:fahem_dashboard/core/utilities/enums.dart';
import 'package:fahem_dashboard/core/utilities/extensions.dart';
import 'package:fahem_dashboard/core/utilities/methods.dart';
import 'package:fahem_dashboard/data/models/secret_consultation_model.dart';
import 'package:fahem_dashboard/domain/usecases/secret_consultations/edit_secret_consultation_usecase.dart';
import 'package:fahem_dashboard/domain/usecases/secret_consultations/insert_secret_consultation_usecase.dart';

class InsertEditSecretConsultationProvider with ChangeNotifier {

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

  UserModel? _user;
  UserModel? get user => _user;
  setUser(UserModel? user) => _user = user;
  changeUser(UserModel? user) {_user = user; notifyListeners();}

  List<String> _images = [];
  List<String> get images => _images;
  setImages(List<String> images) => _images = images;
  void addInImages(String image) {
    if(images.any((element) => element.contains('/') && (element.substring(element.lastIndexOf('/')) ==  image.substring(image.lastIndexOf('/'))))) {
      Methods.showToast(message: Methods.getText(StringsManager.imageAlreadyAdded).toCapitalized());
    }
    else {
      images.add(image);
      notifyListeners();
    }
  }
  void editInImages({required String image, required int index}) {
    if(images.any((element) => element.contains('/') && (element.substring(element.lastIndexOf('/')) ==  image.substring(image.lastIndexOf('/'))))) {
      Methods.showToast(message: Methods.getText(StringsManager.imageAlreadyAdded).toCapitalized());
    }
    else {
      images[index] = image;
      notifyListeners();
    }
  }
  void removeFromImages(int index) {
    images.removeAt(index);
    notifyListeners();
  }

  final List<String> _imagesRandomName = [];
  Future<bool> uploadImages(BuildContext context) async {
    bool isUploadFileError = false;

    changeIsLoading(true);

    for(int i=0; i<_images.length; i++) {
      if(isUploadFileError == false) {
        if(_images[i].startsWith(ConstantsManager.fahemDashboardImageFromFile)) {
          UploadFileParameters uploadFileParameters = UploadFileParameters(
            file: File(_images[i]),
            directory: ApiConstants.secretConsultationsDirectory,
          );
          Either<Failure, String> response = await DependencyInjection.uploadFileUseCase(uploadFileParameters);
          response.fold((failure) async {
            isUploadFileError = true;
            changeIsLoading(false);
            await Dialogs.failureOccurred(context: context, failure: failure);
          }, (image) {
            _imagesRandomName.add(image);
          });
        }
        else {
          _imagesRandomName.add(_images[i]);
        }
      }
    }

    return isUploadFileError;
  }

  bool _isReplied = false;
  bool get isReplied => _isReplied;
  setIsReplied(bool isReplied) => _isReplied = isReplied;
  changeIsReplied(bool isReplied) {_isReplied = isReplied; notifyListeners();}

  bool isAllDataValid() {
    if(_user == null) {
      Methods.showToast(message: Methods.getText(StringsManager.chooseUser).toCapitalized());
      return false;
    }
    return true;
  }

  // region Insert And Edit SecretConsultation
  Future<void> insertSecretConsultation({required BuildContext context, required InsertSecretConsultationParameters insertSecretConsultationParameters}) async {
    changeIsLoading(true);
    bool isUploadFileError = await uploadImages(context);
    if(isUploadFileError == false) {
      insertSecretConsultationParameters.images = _imagesRandomName;
      Either<Failure, SecretConsultationModel> response = await DependencyInjection.insertSecretConsultationUseCase.call(insertSecretConsultationParameters);
      await response.fold((failure) async {
        changeIsLoading(false);
        await Dialogs.failureOccurred(context: context, failure: failure);
      }, (secretConsultation) async {
        changeIsLoading(false);
        Dialogs.showBottomSheetMessage(
          context: context,
          message: Methods.getText(StringsManager.addedSuccessfully).toTitleCase(),
          showMessage: ShowMessage.success,
          thenMethod: () => Navigator.pop(context, secretConsultation),
        );
      });
    }
    else {
      changeIsLoading(false);
    }
  }

  Future<void> editSecretConsultation({required BuildContext context, required EditSecretConsultationParameters editSecretConsultationParameters}) async {
    changeIsLoading(true);
    bool isUploadFileError = await uploadImages(context);
    if(isUploadFileError == false) {
      editSecretConsultationParameters.images = _imagesRandomName;
      Either<Failure, SecretConsultationModel> response = await DependencyInjection.editSecretConsultationUseCase.call(editSecretConsultationParameters);
      await response.fold((failure) async {
        changeIsLoading(false);
        await Dialogs.failureOccurred(context: context, failure: failure);
      }, (secretConsultation) async {
        changeIsLoading(false);
        Dialogs.showBottomSheetMessage(
          context: context,
          message: Methods.getText(StringsManager.modifiedSuccessfully).toTitleCase(),
          showMessage: ShowMessage.success,
          thenMethod: () => Navigator.pop(context, secretConsultation),
        );
      });
    }
    else {
      changeIsLoading(false);
    }
  }
  // endregion
}