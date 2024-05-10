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
import 'package:fahem_business/data/models/category_model.dart';
import 'package:fahem_business/domain/usecases/categories/edit_category_usecase.dart';
import 'package:fahem_business/domain/usecases/categories/insert_category_usecase.dart';

class InsertEditCategoryProvider with ChangeNotifier {

  bool _isLoading = false;
  bool get isLoading => _isLoading;
  changeIsLoading(bool isLoading) {_isLoading = isLoading; notifyListeners();}

  bool _isButtonClicked = false;
  bool get isButtonClicked => _isButtonClicked;
  setIsButtonClicked(bool isButtonClicked) => _isButtonClicked = isButtonClicked;
  changeIsButtonClicked(bool isButtonClicked) {_isButtonClicked = isButtonClicked; notifyListeners();}

  MainCategoryModel? _mainCategory;
  MainCategoryModel? get mainCategory => _mainCategory;
  setMainCategory(MainCategoryModel? mainCategory) => _mainCategory = mainCategory;
  changeMainCategory(MainCategoryModel? mainCategory) {_mainCategory = mainCategory; notifyListeners();}

  dynamic _categoryImage;
  dynamic get categoryImage => _categoryImage;
  setCategoryImage(dynamic categoryImage) => _categoryImage = categoryImage;
  changeCategoryImage(dynamic categoryImage) {_categoryImage = categoryImage; notifyListeners();}

  bool isAllDataValid() {
    if(_categoryImage == null) {
      Methods.showToast(message: Methods.getText(StringsManager.categoryImageIsRequired).toCapitalized());
      return false;
    }
    if(_mainCategory == null) {
      Methods.showToast(message: Methods.getText(StringsManager.chooseMainCategory).toCapitalized());
      return false;
    }
    return true;
  }

  // region Insert And Edit Category
  Future<void> insertCategory({required BuildContext context, required InsertCategoryParameters insertCategoryParameters}) async {
    changeIsLoading(true);
    if(_categoryImage is XFile) {
      String? imageName = await Methods.uploadImage(context: context, imagePath: _categoryImage.path!, directory: ApiConstants.categoriesDirectory);
      insertCategoryParameters.image = imageName!;
    }
    Either<Failure, CategoryModel> response = await DependencyInjection.insertCategoryUseCase.call(insertCategoryParameters);
    response.fold((failure) async {
      changeIsLoading(false);
      await Dialogs.failureOccurred(context: context, failure: failure);
    }, (category) async {
      changeIsLoading(false);
      Dialogs.showBottomSheetMessage(
        context: context,
        message: Methods.getText(StringsManager.addedSuccessfully).toTitleCase(),
        showMessage: ShowMessage.success,
        thenMethod: () => Navigator.pop(context, category),
      );
    });
  }

  Future<void> editCategory({required BuildContext context, required EditCategoryParameters editCategoryParameters}) async {
    changeIsLoading(true);
    if(_categoryImage is XFile) {
      String? imageName = await Methods.uploadImage(context: context, imagePath: _categoryImage.path!, directory: ApiConstants.categoriesDirectory);
      editCategoryParameters.image = imageName!;
    }
    Either<Failure, CategoryModel> response = await DependencyInjection.editCategoryUseCase.call(editCategoryParameters);
    response.fold((failure) async {
      changeIsLoading(false);
      await Dialogs.failureOccurred(context: context, failure: failure);
    }, (category) async {
      changeIsLoading(false);
      Dialogs.showBottomSheetMessage(
        context: context,
        message: Methods.getText(StringsManager.modifiedSuccessfully).toTitleCase(),
        showMessage: ShowMessage.success,
        thenMethod: () => Navigator.pop(context, category),
      );
    });
  }
  // endregion
}