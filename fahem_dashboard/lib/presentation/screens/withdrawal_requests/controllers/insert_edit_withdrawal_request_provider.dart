import 'package:dartz/dartz.dart';
import 'package:fahem_dashboard/data/models/account_model.dart';
import 'package:flutter/material.dart';
import 'package:fahem_dashboard/core/error/failure.dart';
import 'package:fahem_dashboard/core/resources/strings_manager.dart';
import 'package:fahem_dashboard/core/utilities/dependency_injection.dart';
import 'package:fahem_dashboard/core/utilities/dialogs.dart';
import 'package:fahem_dashboard/core/utilities/enums.dart';
import 'package:fahem_dashboard/core/utilities/extensions.dart';
import 'package:fahem_dashboard/core/utilities/methods.dart';
import 'package:fahem_dashboard/data/models/withdrawal_request_model.dart';
import 'package:fahem_dashboard/domain/usecases/withdrawal_requests/edit_withdrawal_request_usecase.dart';
import 'package:fahem_dashboard/domain/usecases/withdrawal_requests/insert_withdrawal_request_usecase.dart';

class InsertEditWithdrawalRequestProvider with ChangeNotifier {

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

  bool isAllDataValid() {
    if(_account == null) {
      Methods.showToast(message: Methods.getText(StringsManager.chooseAccount).toCapitalized());
      return false;
    }
    return true;
  }

  // region Insert And Edit WithdrawalRequest
  Future<void> insertWithdrawalRequest({required BuildContext context, required InsertWithdrawalRequestParameters insertWithdrawalRequestParameters}) async {
    changeIsLoading(true);
    Either<Failure, WithdrawalRequestModel> response = await DependencyInjection.insertWithdrawalRequestUseCase.call(insertWithdrawalRequestParameters);
    await response.fold((failure) async {
      changeIsLoading(false);
      await Dialogs.failureOccurred(context: context, failure: failure);
    }, (withdrawalRequest) async {
      changeIsLoading(false);
      Dialogs.showBottomSheetMessage(
        context: context,
        message: Methods.getText(StringsManager.addedSuccessfully).toTitleCase(),
        showMessage: ShowMessage.success,
        thenMethod: () => Navigator.pop(context, withdrawalRequest),
      );
    });
  }

  Future<void> editWithdrawalRequest({required BuildContext context, required EditWithdrawalRequestParameters editWithdrawalRequestParameters}) async {
    changeIsLoading(true);
    Either<Failure, WithdrawalRequestModel> response = await DependencyInjection.editWithdrawalRequestUseCase.call(editWithdrawalRequestParameters);
    await response.fold((failure) async {
      changeIsLoading(false);
      await Dialogs.failureOccurred(context: context, failure: failure);
    }, (withdrawalRequest) async {
      changeIsLoading(false);
      Dialogs.showBottomSheetMessage(
        context: context,
        message: Methods.getText(StringsManager.modifiedSuccessfully).toTitleCase(),
        showMessage: ShowMessage.success,
        thenMethod: () => Navigator.pop(context, withdrawalRequest),
      );
    });
  }
  // endregion
}