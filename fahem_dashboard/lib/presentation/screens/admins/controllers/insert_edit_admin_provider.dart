import 'package:dartz/dartz.dart';
import 'package:fahem_dashboard/core/utilities/my_providers.dart';
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
import 'package:fahem_dashboard/data/models/admin_model.dart';
import 'package:fahem_dashboard/domain/usecases/admins/edit_admin_usecase.dart';
import 'package:fahem_dashboard/domain/usecases/admins/insert_admin_usecase.dart';

class InsertEditAdminProvider with ChangeNotifier {

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

  bool _isSuper = false;
  bool get isSuper => _isSuper;
  setIsSuper(bool isSuper) => _isSuper = isSuper;
  changeIsSuper(bool isSuper) {_isSuper = isSuper; notifyListeners();}

  List<AdminPermissions> _selectedPermissions = [];
  List<AdminPermissions> get selectedPermissions => _selectedPermissions;
  setSelectedPermissions(List<AdminPermissions> selectedPermissions) => _selectedPermissions = selectedPermissions;
  toggleSelectedPermission(AdminPermissions selectedPermission) {
    int index = _selectedPermissions.indexWhere((element) => element == selectedPermission);
    if(index == -1) {
      _selectedPermissions.add(selectedPermission);
    }
    else {
      _selectedPermissions.removeWhere((element) => element == selectedPermission);
    }
    notifyListeners();
  }

  bool isAllDataValid() {
    return true;
  }

  // region Insert And Edit Admin
  Future<void> insertAdmin({required BuildContext context, required InsertAdminParameters insertAdminParameters}) async {
    changeIsLoading(true);
    if(_personalImage is XFile) {
      String? imageName = await Methods.uploadImage(context: context, imagePath: _personalImage.path!, directory: ApiConstants.adminsDirectory);
      insertAdminParameters.personalImage = imageName;
    }
    if(_coverImage is XFile) {
      String? imageName = await Methods.uploadImage(context: context, imagePath: _coverImage.path!, directory: ApiConstants.adminsDirectory);
      insertAdminParameters.coverImage = imageName;
    }
    Either<Failure, AdminModel> response = await DependencyInjection.insertAdminUseCase.call(insertAdminParameters);
    await response.fold((failure) async {
      changeIsLoading(false);
      await Dialogs.failureOccurred(context: context, failure: failure);
    }, (admin) async {
      changeIsLoading(false);
      Dialogs.showBottomSheetMessage(
        context: context,
        message: Methods.getText(StringsManager.addedSuccessfully).toTitleCase(),
        showMessage: ShowMessage.success,
        thenMethod: () => Navigator.pop(context, admin),
      );
    });
  }

  Future<void> editAdmin({required BuildContext context, required EditAdminParameters editAdminParameters}) async {
    changeIsLoading(true);
    if(_personalImage is XFile) {
      String? imageName = await Methods.uploadImage(context: context, imagePath: _personalImage.path!, directory: ApiConstants.adminsDirectory);
      editAdminParameters.personalImage = imageName;
    }
    if(_coverImage is XFile) {
      String? imageName = await Methods.uploadImage(context: context, imagePath: _coverImage.path!, directory: ApiConstants.adminsDirectory);
      editAdminParameters.coverImage = imageName;
    }
    Either<Failure, AdminModel> response = await DependencyInjection.editAdminUseCase.call(editAdminParameters);
    await response.fold((failure) async {
      changeIsLoading(false);
      await Dialogs.failureOccurred(context: context, failure: failure);
    }, (admin) async {
      changeIsLoading(false);
      if (MyProviders.authenticationProvider.currentAdmin.adminId == admin.adminId) {
        MyProviders.authenticationProvider.changeCurrentAdmin(admin);
      }
      Dialogs.showBottomSheetMessage(
        context: context,
        message: Methods.getText(StringsManager.modifiedSuccessfully).toTitleCase(),
        showMessage: ShowMessage.success,
        thenMethod: () => Navigator.pop(context, admin),
      );
    });
  }
  // endregion
}