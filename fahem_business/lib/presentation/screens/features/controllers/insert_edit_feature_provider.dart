import 'package:dartz/dartz.dart';
import 'package:fahem_business/data/models/main_category_model.dart';
import 'package:flutter/material.dart';
import 'package:fahem_business/core/error/failure.dart';
import 'package:fahem_business/core/resources/strings_manager.dart';
import 'package:fahem_business/core/utilities/dependency_injection.dart';
import 'package:fahem_business/core/utilities/dialogs.dart';
import 'package:fahem_business/core/utilities/enums.dart';
import 'package:fahem_business/core/utilities/extensions.dart';
import 'package:fahem_business/core/utilities/methods.dart';
import 'package:fahem_business/data/models/feature_model.dart';
import 'package:fahem_business/domain/usecases/features/edit_feature_usecase.dart';
import 'package:fahem_business/domain/usecases/features/insert_feature_usecase.dart';

class InsertEditFeatureProvider with ChangeNotifier {

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

  MainCategoryModel? _mainCategory;
  MainCategoryModel? get mainCategory => _mainCategory;
  setMainCategory(MainCategoryModel? mainCategory) => _mainCategory = mainCategory;
  changeMainCategory(MainCategoryModel? mainCategory) {_mainCategory = mainCategory; notifyListeners();}

  bool isAllDataValid() {
    if(_mainCategory == null) {
      Methods.showToast(message: Methods.getText(StringsManager.chooseMainCategory).toCapitalized());
      return false;
    }
    return true;
  }

  // region Insert And Edit Feature
  Future<void> insertFeature({required BuildContext context, required InsertFeatureParameters insertFeatureParameters}) async {
    changeIsLoading(true);
    Either<Failure, FeatureModel> response = await DependencyInjection.insertFeatureUseCase.call(insertFeatureParameters);
    await response.fold((failure) async {
      changeIsLoading(false);
      await Dialogs.failureOccurred(context: context, failure: failure);
    }, (feature) async {
      changeIsLoading(false);
      Dialogs.showBottomSheetMessage(
        context: context,
        message: Methods.getText(StringsManager.addedSuccessfully).toTitleCase(),
        showMessage: ShowMessage.success,
        thenMethod: () => Navigator.pop(context, feature),
      );
    });
  }

  Future<void> editFeature({required BuildContext context, required EditFeatureParameters editFeatureParameters}) async {
    changeIsLoading(true);
    Either<Failure, FeatureModel> response = await DependencyInjection.editFeatureUseCase.call(editFeatureParameters);
    await response.fold((failure) async {
      changeIsLoading(false);
      await Dialogs.failureOccurred(context: context, failure: failure);
    }, (feature) async {
      changeIsLoading(false);
      Dialogs.showBottomSheetMessage(
        context: context,
        message: Methods.getText(StringsManager.modifiedSuccessfully).toTitleCase(),
        showMessage: ShowMessage.success,
        thenMethod: () => Navigator.pop(context, feature),
      );
    });
  }
  // endregion
}