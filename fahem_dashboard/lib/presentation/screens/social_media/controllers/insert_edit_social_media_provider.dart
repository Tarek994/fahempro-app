import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:fahem_dashboard/core/error/failure.dart';
import 'package:fahem_dashboard/core/network/api_constants.dart';
import 'package:fahem_dashboard/core/resources/strings_manager.dart';
import 'package:fahem_dashboard/core/utilities/dependency_injection.dart';
import 'package:fahem_dashboard/core/utilities/dialogs.dart';
import 'package:fahem_dashboard/core/utilities/enums.dart';
import 'package:fahem_dashboard/core/utilities/extensions.dart';
import 'package:fahem_dashboard/core/utilities/methods.dart';
import 'package:fahem_dashboard/data/models/social_media_model.dart';
import 'package:fahem_dashboard/domain/usecases/social_media/edit_social_media_usecase.dart';
import 'package:fahem_dashboard/domain/usecases/social_media/insert_social_media_usecase.dart';

class InsertEditSocialMediaProvider with ChangeNotifier {

  bool _isLoading = false;
  bool get isLoading => _isLoading;
  changeIsLoading(bool isLoading) {_isLoading = isLoading; notifyListeners();}

  dynamic _socialMediaImage;
  dynamic get socialMediaImage => _socialMediaImage;
  setSocialMediaImage(dynamic socialMediaImage) => _socialMediaImage = socialMediaImage;
  changeSocialMediaImage(dynamic socialMediaImage) {_socialMediaImage = socialMediaImage; notifyListeners();}

  bool _isAvailable = false;
  bool get isAvailable => _isAvailable;
  setIsAvailable(bool isAvailable) => _isAvailable = isAvailable;
  changeIsAvailable(bool isAvailable) {_isAvailable = isAvailable; notifyListeners();}

  bool isAllDataValid() {
    if(_socialMediaImage == null) {
      Methods.showToast(message: Methods.getText(StringsManager.imageIsRequired).toCapitalized());
      return false;
    }
    return true;
  }

  // region Insert And Edit SocialMedia
  Future<void> insertSocialMedia({required BuildContext context, required InsertSocialMediaParameters insertSocialMediaParameters}) async {
    changeIsLoading(true);
    if(_socialMediaImage is XFile) {
      String? imageName = await Methods.uploadImage(context: context, imagePath: _socialMediaImage.path!, directory: ApiConstants.socialMediaDirectory);
      insertSocialMediaParameters.image = imageName!;
    }
    Either<Failure, SocialMediaModel> response = await DependencyInjection.insertSocialMediaUseCase.call(insertSocialMediaParameters);
    await response.fold((failure) async {
      changeIsLoading(false);
      await Dialogs.failureOccurred(context: context, failure: failure);
    }, (socialMedia) async {
      changeIsLoading(false);
      Dialogs.showBottomSheetMessage(
        context: context,
        message: Methods.getText(StringsManager.addedSuccessfully).toTitleCase(),
        showMessage: ShowMessage.success,
        thenMethod: () => Navigator.pop(context, socialMedia),
      );
    });
  }

  Future<void> editSocialMedia({required BuildContext context, required EditSocialMediaParameters editSocialMediaParameters}) async {
    changeIsLoading(true);
    if(_socialMediaImage is XFile) {
      String? imageName = await Methods.uploadImage(context: context, imagePath: _socialMediaImage.path!, directory: ApiConstants.socialMediaDirectory);
      editSocialMediaParameters.image = imageName!;
    }
    Either<Failure, SocialMediaModel> response = await DependencyInjection.editSocialMediaUseCase.call(editSocialMediaParameters);
    await response.fold((failure) async {
      changeIsLoading(false);
      await Dialogs.failureOccurred(context: context, failure: failure);
    }, (socialMedia) async {
      changeIsLoading(false);
      Dialogs.showBottomSheetMessage(
        context: context,
        message: Methods.getText(StringsManager.modifiedSuccessfully).toTitleCase(),
        showMessage: ShowMessage.success,
        thenMethod: () => Navigator.pop(context, socialMedia),
      );
    });
  }
  // endregion
}