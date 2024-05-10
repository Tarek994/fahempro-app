import 'package:dartz/dartz.dart';
import 'package:fahem_dashboard/data/models/account_model.dart';
import 'package:fahem_dashboard/data/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:fahem_dashboard/core/error/failure.dart';
import 'package:fahem_dashboard/core/resources/strings_manager.dart';
import 'package:fahem_dashboard/core/utilities/dependency_injection.dart';
import 'package:fahem_dashboard/core/utilities/dialogs.dart';
import 'package:fahem_dashboard/core/utilities/enums.dart';
import 'package:fahem_dashboard/core/utilities/extensions.dart';
import 'package:fahem_dashboard/core/utilities/methods.dart';
import 'package:fahem_dashboard/data/models/wallet_history_model.dart';
import 'package:fahem_dashboard/domain/usecases/wallet_history/edit_wallet_history_usecase.dart';
import 'package:fahem_dashboard/domain/usecases/wallet_history/insert_wallet_history_usecase.dart';

class InsertEditWalletHistoryProvider with ChangeNotifier {

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

  bool isAllDataValid({required UserType userType}) {
    if(userType == UserType.account && _account == null) {
      Methods.showToast(message: Methods.getText(StringsManager.chooseAccount).toCapitalized());
      return false;
    }
    if(userType == UserType.user && _user == null) {
      Methods.showToast(message: Methods.getText(StringsManager.chooseUser).toCapitalized());
      return false;
    }
    return true;
  }

  // region Insert And Edit WalletHistory
  Future<void> insertWalletHistory({required BuildContext context, required InsertWalletHistoryParameters insertWalletHistoryParameters}) async {
    changeIsLoading(true);
    Either<Failure, WalletHistoryModel> response = await DependencyInjection.insertWalletHistoryUseCase.call(insertWalletHistoryParameters);
    await response.fold((failure) async {
      changeIsLoading(false);
      await Dialogs.failureOccurred(context: context, failure: failure);
    }, (walletHistory) async {
      changeIsLoading(false);
      Dialogs.showBottomSheetMessage(
        context: context,
        message: Methods.getText(StringsManager.addedSuccessfully).toTitleCase(),
        showMessage: ShowMessage.success,
        thenMethod: () => Navigator.pop(context, walletHistory),
      );
    });
  }

  Future<void> editWalletHistory({required BuildContext context, required EditWalletHistoryParameters editWalletHistoryParameters}) async {
    changeIsLoading(true);
    Either<Failure, WalletHistoryModel> response = await DependencyInjection.editWalletHistoryUseCase.call(editWalletHistoryParameters);
    await response.fold((failure) async {
      changeIsLoading(false);
      await Dialogs.failureOccurred(context: context, failure: failure);
    }, (walletHistory) async {
      changeIsLoading(false);
      Dialogs.showBottomSheetMessage(
        context: context,
        message: Methods.getText(StringsManager.modifiedSuccessfully).toTitleCase(),
        showMessage: ShowMessage.success,
        thenMethod: () => Navigator.pop(context, walletHistory),
      );
    });
  }
  // endregion
}