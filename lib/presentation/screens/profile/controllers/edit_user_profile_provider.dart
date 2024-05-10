import 'package:dartz/dartz.dart';
import 'package:fahem/core/helper/cache_helper.dart';
import 'package:fahem/core/resources/constants_manager.dart';
import 'package:fahem/core/utilities/my_providers.dart';
import 'package:fahem/data/models/static/country_model.dart';
import 'package:fahem/domain/usecases/authentication_user/edit_user_profile_usecase.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:fahem/core/error/failure.dart';
import 'package:fahem/core/network/api_constants.dart';
import 'package:fahem/core/resources/strings_manager.dart';
import 'package:fahem/core/utilities/dependency_injection.dart';
import 'package:fahem/core/utilities/dialogs.dart';
import 'package:fahem/core/utilities/enums.dart';
import 'package:fahem/core/utilities/extensions.dart';
import 'package:fahem/core/utilities/methods.dart';
import 'package:fahem/data/models/user_model.dart';

class EditUserProfileProvider with ChangeNotifier {

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

  dynamic _personalImage;
  dynamic get personalImage => _personalImage;
  setPersonalImage(dynamic personalImage) => _personalImage = personalImage;
  changePersonalImage(dynamic personalImage) {_personalImage = personalImage; notifyListeners();}

  dynamic _coverImage;
  dynamic get coverImage => _coverImage;
  setCoverImage(dynamic coverImage) => _coverImage = coverImage;
  changeCoverImage(dynamic coverImage) {_coverImage = coverImage; notifyListeners();}

  DateTime? _birthDate;
  DateTime? get birthDate => _birthDate;
  setBirthDate(DateTime? birthDate) => _birthDate = birthDate;
  changeBirthDate(DateTime? birthDate) {_birthDate = birthDate; notifyListeners();}
  Future<void> onPressedBirthDate(BuildContext context) async {
    await Methods.selectDateFromPicker(
      context: context,
      title: StringsManager.selectBirthDate,
      initialDate: birthDate ?? DateTime.now(),
      firstDate: DateTime(1950),
      lastDate: DateTime.now(),
    ).then((dateTime) {
      if(dateTime != null) {changeBirthDate(dateTime);}
    });
  }

  CountryModel _dialingCode = ConstantsManager.egyptCountryModel;
  CountryModel get dialingCode => _dialingCode;
  setDialingCode(CountryModel dialingCode) => _dialingCode = dialingCode;
  changeDialingCode(CountryModel dialingCode)  {_dialingCode = dialingCode; notifyListeners();}

  bool isAllDataValid() {
    // if(_personalImage == null) {
    //   Methods.showToast(message: Methods.getText(StringsManager.personalImageIsRequired).toCapitalized());
    //   return false;
    // }
    // if(_governorate == null) {return false;}
    // if(_tasks.isEmpty) {
    //   Methods.showToast(message: Methods.getText(StringsManager.tasksRequired).toCapitalized());
    //   return false;
    // }
    return true;
  }

  // region Edit User Profile
  Future<void> editUserProfile({required BuildContext context, required EditUserProfileParameters parameters}) async {
    changeIsLoading(true);
    if(_personalImage is XFile) {
      String? imageName = await Methods.uploadImage(context: context, imagePath: _personalImage.path!, directory: ApiConstants.usersDirectory);
      parameters.personalImage = imageName;
    }
    if(_coverImage is XFile) {
      String? imageName = await Methods.uploadImage(context: context, imagePath: _coverImage.path!, directory: ApiConstants.usersDirectory);
      parameters.coverImage = imageName;
    }
    Either<Failure, UserModel> response = await DependencyInjection.editUserProfileUseCase.call(parameters);
    await response.fold((failure) async {
      changeIsLoading(false);
      await Dialogs.failureOccurred(context: context, failure: failure);
    }, (user) async {
      changeIsLoading(false);
      CacheHelper.setData(key: CacheHelper.currentUserIdKey, value: user.userId);
      MyProviders.authenticationProvider.changeCurrentUser(user);
      Dialogs.showBottomSheetMessage(
        context: context,
        message: Methods.getText(StringsManager.modifiedSuccessfully).toTitleCase(),
        showMessage: ShowMessage.success,
        thenMethod: () => Navigator.pop(context, user),
      );
    });
  }
  // endregion
}