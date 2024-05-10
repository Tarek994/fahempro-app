import 'package:dartz/dartz.dart';
import 'package:fahem_dashboard/data/models/account_model.dart';
import 'package:fahem_dashboard/data/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:fahem_dashboard/core/error/failure.dart';
import 'package:fahem_dashboard/core/network/firebase_constants.dart';
import 'package:fahem_dashboard/core/resources/strings_manager.dart';
import 'package:fahem_dashboard/core/services/notification_service.dart';
import 'package:fahem_dashboard/core/utilities/dependency_injection.dart';
import 'package:fahem_dashboard/core/utilities/dialogs.dart';
import 'package:fahem_dashboard/core/utilities/enums.dart';
import 'package:fahem_dashboard/core/utilities/extensions.dart';
import 'package:fahem_dashboard/core/utilities/methods.dart';
import 'package:fahem_dashboard/data/models/notification_model.dart';
import 'package:fahem_dashboard/domain/usecases/notifications/insert_notification_usecase.dart';

class SendNotificationProvider with ChangeNotifier {

  bool _isLoading = false;
  bool get isLoading => _isLoading;
  changeIsLoading(bool isLoading) {_isLoading = isLoading; notifyListeners();}

  bool _isButtonClicked = false;
  bool get isButtonClicked => _isButtonClicked;
  setIsButtonClicked(bool isButtonClicked) => _isButtonClicked = isButtonClicked;
  changeIsButtonClicked(bool isButtonClicked) {_isButtonClicked = isButtonClicked; notifyListeners();}

  UserModel? _selectedUser;
  UserModel? get selectedUser => _selectedUser;
  setSelectedUser(UserModel? selectedUser) => _selectedUser = selectedUser;
  changeSelectedUser(UserModel? selectedUser) {_selectedUser = selectedUser; notifyListeners();}

  AccountModel? _selectedAccount;
  AccountModel? get selectedAccount => _selectedAccount;
  setSelectedAccount(AccountModel? selectedAccount) => _selectedAccount = selectedAccount;
  changeSelectedAccount(AccountModel? selectedAccount) {_selectedAccount = selectedAccount; notifyListeners();}

  bool isAllDataValid() {
    return true;
  }

  // region Insert Notification
  Future<void> insertNotification({
    required BuildContext context,
    required InsertNotificationParameters insertNotificationParameters,
  }) async {
    String topic = '';
    if(insertNotificationParameters.notificationToApp == NotificationToApp.fahem) {
      if(insertNotificationParameters.notificationTo == NotificationTo.all) {
        topic = FirebaseConstants.fahemTopic;
      }
      if(insertNotificationParameters.notificationTo == NotificationTo.one && insertNotificationParameters.userId != null) {
        topic = '${FirebaseConstants.userPrefix}${insertNotificationParameters.userId}';
      }
    }
    if(insertNotificationParameters.notificationToApp == NotificationToApp.fahemBusiness) {
      if(insertNotificationParameters.notificationTo == NotificationTo.all) {
        topic = FirebaseConstants.fahemBusinessTopic;
      }
      if(insertNotificationParameters.notificationTo == NotificationTo.one && insertNotificationParameters.accountId != null) {
        topic = '${FirebaseConstants.accountPrefix}${insertNotificationParameters.accountId}';
      }
    }

    changeIsLoading(true);
    await NotificationService.pushNotification(
      topic: topic,
      title: insertNotificationParameters.title,
      body: insertNotificationParameters.body,
    ).then((_) async {
      Either<Failure, NotificationModel> response = await DependencyInjection.insertNotificationUseCase.call(insertNotificationParameters);
      await response.fold((failure) async {
        changeIsLoading(false);
        await Dialogs.failureOccurred(context: context, failure: failure);
      }, (notification) async {
        changeIsLoading(false);
        Dialogs.showBottomSheetMessage(
          context: context,
          message: Methods.getText(StringsManager.sentSuccessfully).toTitleCase(),
          showMessage: ShowMessage.success,
          thenMethod: () => Navigator.pop(context),
        );
      });
    });
  }
  // endregion
}