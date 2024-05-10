import 'package:dartz/dartz.dart';
import 'package:fahem/data/models/account_model.dart';
import 'package:fahem/data/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:fahem/core/error/failure.dart';
import 'package:fahem/core/resources/strings_manager.dart';
import 'package:fahem/core/utilities/dependency_injection.dart';
import 'package:fahem/core/utilities/dialogs.dart';
import 'package:fahem/core/utilities/enums.dart';
import 'package:fahem/core/utilities/extensions.dart';
import 'package:fahem/core/utilities/methods.dart';
import 'package:fahem/data/models/phone_number_request_model.dart';
import 'package:fahem/domain/usecases/phone_number_requests/edit_phone_number_request_usecase.dart';
import 'package:fahem/domain/usecases/phone_number_requests/insert_phone_number_request_usecase.dart';

class InsertEditPhoneNumberRequestProvider with ChangeNotifier {

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

  bool isAllDataValid() {
    if(_account == null) {
      Methods.showToast(message: Methods.getText(StringsManager.chooseAccount).toCapitalized());
      return false;
    }
    if(_user == null) {
      Methods.showToast(message: Methods.getText(StringsManager.chooseUser).toCapitalized());
      return false;
    }
    return true;
  }

  // region Insert And Edit PhoneNumberRequest
  Future<void> insertPhoneNumberRequest({required BuildContext context, required InsertPhoneNumberRequestParameters insertPhoneNumberRequestParameters}) async {
    changeIsLoading(true);
    Either<Failure, PhoneNumberRequestModel> response = await DependencyInjection.insertPhoneNumberRequestUseCase.call(insertPhoneNumberRequestParameters);
    await response.fold((failure) async {
      changeIsLoading(false);
      await Dialogs.failureOccurred(context: context, failure: failure);
    }, (phoneNumberRequest) async {
      changeIsLoading(false);
      Dialogs.showBottomSheetMessage(
        context: context,
        message: Methods.getText(StringsManager.addedSuccessfully).toTitleCase(),
        showMessage: ShowMessage.success,
        thenMethod: () => Navigator.pop(context, phoneNumberRequest),
      );
    });
  }

  Future<void> editPhoneNumberRequest({required BuildContext context, required EditPhoneNumberRequestParameters editPhoneNumberRequestParameters}) async {
    changeIsLoading(true);
    Either<Failure, PhoneNumberRequestModel> response = await DependencyInjection.editPhoneNumberRequestUseCase.call(editPhoneNumberRequestParameters);
    await response.fold((failure) async {
      changeIsLoading(false);
      await Dialogs.failureOccurred(context: context, failure: failure);
    }, (phoneNumberRequest) async {
      changeIsLoading(false);
      Dialogs.showBottomSheetMessage(
        context: context,
        message: Methods.getText(StringsManager.modifiedSuccessfully).toTitleCase(),
        showMessage: ShowMessage.success,
        thenMethod: () => Navigator.pop(context, phoneNumberRequest),
      );
    });
  }
  // endregion
}