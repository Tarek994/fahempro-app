import 'package:dartz/dartz.dart';
import 'package:fahem_dashboard/presentation/btm_sheets/countries_btm_sheet.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';
import 'package:fahem_dashboard/core/error/failure.dart';
import 'package:fahem_dashboard/core/network/api_constants.dart';
import 'package:fahem_dashboard/core/resources/strings_manager.dart';
import 'package:fahem_dashboard/core/utilities/dependency_injection.dart';
import 'package:fahem_dashboard/core/utilities/dialogs.dart';
import 'package:fahem_dashboard/core/utilities/enums.dart';
import 'package:fahem_dashboard/core/utilities/extensions.dart';
import 'package:fahem_dashboard/core/utilities/methods.dart';
import 'package:fahem_dashboard/data/models/static/country_model.dart';
import 'package:fahem_dashboard/data/models/user_model.dart';
import 'package:fahem_dashboard/domain/usecases/users/edit_user_usecase.dart';
import 'package:fahem_dashboard/domain/usecases/users/insert_user_usecase.dart';

class InsertEditUserProvider with ChangeNotifier {

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

  CountryModel? _country;
  CountryModel? get country => _country;
  setCountry(CountryModel? country) => _country = country;
  changeCountry(CountryModel? country)  {_country = country; notifyListeners();}
  void onPressedCountry(BuildContext context) {
    FocusScope.of(context).unfocus();
    Dialogs.showBottomSheet(
      context: context,
      child: const CountriesBtmSheet(showDialingCode: false),
      thenMethod: () {
        if(selectedCountryInBtmSheet != null) {
          changeCountry(selectedCountryInBtmSheet);
        }
      },
    );
  }

  CountryModel? _dialingCode;
  CountryModel? get dialingCode => _dialingCode;
  setDialingCode(CountryModel? dialingCode) => _dialingCode = dialingCode;
  changeDialingCode(CountryModel? dialingCode)  {_dialingCode = dialingCode; notifyListeners();}
  void onPressedDialingCode(BuildContext context) {
    FocusScope.of(context).unfocus();
    Dialogs.showBottomSheet(
      context: context,
      child: const CountriesBtmSheet(showDialingCode: true),
      thenMethod: () {
        if(selectedCountryInBtmSheet != null) {
          changeDialingCode(selectedCountryInBtmSheet);
        }
      },
    );
  }

  Position? _position;
  Position? get position => _position;
  setPosition(Position? position) => _position = position;
  changePosition(Position? position) {_position = position; notifyListeners();}

  bool _isDetectLocationClicked = false;
  bool get isDetectLocationClicked => _isDetectLocationClicked;
  setIsDetectLocationClicked(bool isDetectLocationClicked) => _isDetectLocationClicked = isDetectLocationClicked;
  changeIsDetectLocationClicked(bool isDetectLocationClicked) {_isDetectLocationClicked = isDetectLocationClicked; notifyListeners();}

  bool _isFeatured = false;
  bool get isFeatured => _isFeatured;
  setIsFeatured(bool isFeatured) => _isFeatured = isFeatured;
  changeIsFeatured(bool isFeatured) {_isFeatured = isFeatured; notifyListeners();}

  bool isAllDataValid() {
    if(_personalImage == null) {
      Methods.showToast(message: Methods.getText(StringsManager.personalImageIsRequired).toCapitalized());
      return false;
    }
    if(_birthDate == null) {return false;}
    if(_country == null) {return false;}
    if(_dialingCode == null) {return false;}
    return true;
  }

  // region Insert And Edit User
  Future<void> insertUser({required BuildContext context, required InsertUserParameters insertUserParameters}) async {
    changeIsLoading(true);
    if(_personalImage is XFile) {
      String? imageName = await Methods.uploadImage(context: context, imagePath: _personalImage.path!, directory: ApiConstants.usersDirectory);
      insertUserParameters.personalImage = imageName;
    }
    if(_coverImage is XFile) {
      String? imageName = await Methods.uploadImage(context: context, imagePath: _coverImage.path!, directory: ApiConstants.usersDirectory);
      insertUserParameters.coverImage = imageName;
    }
    Either<Failure, UserModel> response = await DependencyInjection.insertUserUseCase.call(insertUserParameters);
    await response.fold((failure) async {
      changeIsLoading(false);
      await Dialogs.failureOccurred(context: context, failure: failure);
    }, (user) async {
      changeIsLoading(false);
      Dialogs.showBottomSheetMessage(
        context: context,
        message: Methods.getText(StringsManager.addedSuccessfully).toTitleCase(),
        showMessage: ShowMessage.success,
        thenMethod: () => Navigator.pop(context, user),
      );
    });
  }

  Future<void> editUser({required BuildContext context, required EditUserParameters editUserParameters}) async {
    changeIsLoading(true);
    if(_personalImage is XFile) {
      String? imageName = await Methods.uploadImage(context: context, imagePath: _personalImage.path!, directory: ApiConstants.usersDirectory);
      editUserParameters.personalImage = imageName;
    }
    if(_coverImage is XFile) {
      String? imageName = await Methods.uploadImage(context: context, imagePath: _coverImage.path!, directory: ApiConstants.usersDirectory);
      editUserParameters.coverImage = imageName;
    }
    Either<Failure, UserModel> response = await DependencyInjection.editUserUseCase.call(editUserParameters);
    await response.fold((failure) async {
      changeIsLoading(false);
      await Dialogs.failureOccurred(context: context, failure: failure);
    }, (user) async {
      changeIsLoading(false);
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