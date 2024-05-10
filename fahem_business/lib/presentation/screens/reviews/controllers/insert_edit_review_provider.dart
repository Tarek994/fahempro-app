import 'package:dartz/dartz.dart';
import 'package:fahem_business/data/models/account_model.dart';
import 'package:fahem_business/data/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:fahem_business/core/error/failure.dart';
import 'package:fahem_business/core/resources/strings_manager.dart';
import 'package:fahem_business/core/utilities/dependency_injection.dart';
import 'package:fahem_business/core/utilities/dialogs.dart';
import 'package:fahem_business/core/utilities/enums.dart';
import 'package:fahem_business/core/utilities/extensions.dart';
import 'package:fahem_business/core/utilities/methods.dart';
import 'package:fahem_business/data/models/review_model.dart';
import 'package:fahem_business/domain/usecases/reviews/edit_review_usecase.dart';
import 'package:fahem_business/domain/usecases/reviews/insert_review_usecase.dart';

class InsertEditReviewProvider with ChangeNotifier {

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

  AccountModel? _account;
  AccountModel? get account => _account;
  setAccount(AccountModel? account) => _account = account;
  changeAccount(AccountModel? account) {_account = account; notifyListeners();}

  UserModel? _user;
  UserModel? get user => _user;
  setUser(UserModel? user) => _user = user;
  changeUser(UserModel? user) {_user = user; notifyListeners();}

  List<String> _featuresAr = [];
  List<String> get featuresAr => _featuresAr;
  setFeaturesAr(List<String> featuresAr) => _featuresAr = featuresAr;
  changeFeaturesAr(List<String> featuresAr) {_featuresAr = featuresAr; notifyListeners();}
  addInFeaturesAr(String featureAr) {
    if(!_featuresAr.contains(featureAr) && featureAr.isNotEmpty) {
      _featuresAr.add(featureAr);
      notifyListeners();
    }
  }
  removeFromFeaturesAr(String featureAr) {
    _featuresAr.removeWhere((element) => element == featureAr);
    notifyListeners();
  }

  List<String> _featuresEn = [];
  List<String> get featuresEn => _featuresEn;
  setFeaturesEn(List<String> featuresEn) => _featuresEn = featuresEn;
  changeFeaturesEn(List<String> featuresEn) {_featuresEn = featuresEn; notifyListeners();}
  addInFeaturesEn(String featureEn) {
    if(!_featuresEn.contains(featureEn) && featureEn.isNotEmpty) {
      _featuresEn.add(featureEn);
      notifyListeners();
    }
  }
  removeFromFeaturesEn(String featureEn) {
    _featuresEn.removeWhere((element) => element == featureEn);
    notifyListeners();
  }

  bool isAllDataValid() {
    if(_account == null) {
      Methods.showToast(message: Methods.getText(StringsManager.chooseAccount).toCapitalized());
      return false;
    }
    if(_user == null) {
      Methods.showToast(message: Methods.getText(StringsManager.chooseUser).toCapitalized());
      return false;
    }
    // if(_featuresAr.isEmpty) {
    //   Methods.showToast(message: Methods.getText(StringsManager.featuresRequired).toCapitalized());
    //   return false;
    // }
    // if(_featuresEn.isEmpty) {
    //   Methods.showToast(message: Methods.getText(StringsManager.featuresRequired).toCapitalized());
    //   return false;
    // }
    return true;
  }

  // region Insert And Edit Review
  Future<void> insertReview({required BuildContext context, required InsertReviewParameters insertReviewParameters}) async {
    changeIsLoading(true);
    Either<Failure, ReviewModel> response = await DependencyInjection.insertReviewUseCase.call(insertReviewParameters);
    await response.fold((failure) async {
      changeIsLoading(false);
      await Dialogs.failureOccurred(context: context, failure: failure);
    }, (review) async {
      changeIsLoading(false);
      Dialogs.showBottomSheetMessage(
        context: context,
        message: Methods.getText(StringsManager.addedSuccessfully).toTitleCase(),
        showMessage: ShowMessage.success,
        thenMethod: () => Navigator.pop(context, review),
      );
    });
  }

  Future<void> editReview({required BuildContext context, required EditReviewParameters editReviewParameters}) async {
    changeIsLoading(true);
    Either<Failure, ReviewModel> response = await DependencyInjection.editReviewUseCase.call(editReviewParameters);
    await response.fold((failure) async {
      changeIsLoading(false);
      await Dialogs.failureOccurred(context: context, failure: failure);
    }, (review) async {
      changeIsLoading(false);
      Dialogs.showBottomSheetMessage(
        context: context,
        message: Methods.getText(StringsManager.modifiedSuccessfully).toTitleCase(),
        showMessage: ShowMessage.success,
        thenMethod: () => Navigator.pop(context, review),
      );
    });
  }
  // endregion
}