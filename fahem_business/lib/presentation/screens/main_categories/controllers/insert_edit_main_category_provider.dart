import 'package:dartz/dartz.dart';
import 'package:fahem_business/data/models/main_category_model.dart';
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
import 'package:fahem_business/domain/usecases/main_categories/edit_main_category_usecase.dart';
import 'package:fahem_business/domain/usecases/main_categories/insert_main_category_usecase.dart';

class InsertEditMainCategoryProvider with ChangeNotifier {

  bool _isLoading = false;
  bool get isLoading => _isLoading;
  changeIsLoading(bool isLoading) {_isLoading = isLoading; notifyListeners();}

  dynamic _mainCategoryImage;
  dynamic get mainCategoryImage => _mainCategoryImage;
  setMainCategoryImage(dynamic mainCategoryImage) => _mainCategoryImage = mainCategoryImage;
  changeMainCategoryImage(dynamic mainCategoryImage) {_mainCategoryImage = mainCategoryImage; notifyListeners();}

  bool isAllDataValid() {
    if(_mainCategoryImage == null) {
      Methods.showToast(message: Methods.getText(StringsManager.imageIsRequired).toCapitalized());
      return false;
    }
    return true;
  }

  // region Insert And Edit MainCategory
  Future<void> insertMainCategory({required BuildContext context, required InsertMainCategoryParameters insertMainCategoryParameters}) async {
    changeIsLoading(true);
    if(_mainCategoryImage is XFile) {
      String? imageName = await Methods.uploadImage(context: context, imagePath: _mainCategoryImage.path!, directory: ApiConstants.mainCategoriesDirectory);
      insertMainCategoryParameters.image = imageName!;
    }
    Either<Failure, MainCategoryModel> response = await DependencyInjection.insertMainCategoryUseCase.call(insertMainCategoryParameters);
    response.fold((failure) async {
      changeIsLoading(false);
      await Dialogs.failureOccurred(context: context, failure: failure);
    }, (mainCategory) async {
      changeIsLoading(false);
      Dialogs.showBottomSheetMessage(
        context: context,
        message: Methods.getText(StringsManager.addedSuccessfully).toTitleCase(),
        showMessage: ShowMessage.success,
        thenMethod: () => Navigator.pop(context, mainCategory),
      );
    });
  }

  Future<void> editMainCategory({required BuildContext context, required EditMainCategoryParameters editMainCategoryParameters}) async {
    changeIsLoading(true);
    if(_mainCategoryImage is XFile) {
      String? imageName = await Methods.uploadImage(context: context, imagePath: _mainCategoryImage.path!, directory: ApiConstants.mainCategoriesDirectory);
      editMainCategoryParameters.image = imageName!;
    }
    Either<Failure, MainCategoryModel> response = await DependencyInjection.editMainCategoryUseCase.call(editMainCategoryParameters);
    response.fold((failure) async {
      changeIsLoading(false);
      await Dialogs.failureOccurred(context: context, failure: failure);
    }, (mainCategory) async {
      changeIsLoading(false);
      Dialogs.showBottomSheetMessage(
        context: context,
        message: Methods.getText(StringsManager.modifiedSuccessfully).toTitleCase(),
        showMessage: ShowMessage.success,
        thenMethod: () => Navigator.pop(context, mainCategory),
      );
    });
  }
  // endregion
}