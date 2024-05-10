import 'package:dartz/dartz.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:fahem_dashboard/core/error/failure.dart';
import 'package:fahem_dashboard/core/services/email_service.dart';
import 'package:fahem_dashboard/core/utilities/dependency_injection.dart';
import 'package:fahem_dashboard/core/utilities/dialogs.dart';
import 'package:fahem_dashboard/core/utilities/enums.dart';
import 'package:fahem_dashboard/core/utilities/extensions.dart';
import 'package:fahem_dashboard/core/utilities/my_providers.dart';
import 'package:fahem_dashboard/data/models/admin_model.dart';
import 'package:fahem_dashboard/domain/usecases/authentication_admin/change_admin_password_usecase.dart';
import 'package:fahem_dashboard/domain/usecases/authentication_admin/check_admin_email_to_reset_password_usecase.dart';
import 'package:fahem_dashboard/domain/usecases/authentication_admin/delete_admin_account_usecase.dart';
import 'package:fahem_dashboard/domain/usecases/authentication_admin/get_admin_with_id_usecase.dart';
import 'package:fahem_dashboard/domain/usecases/authentication_admin/login_admin_usecase.dart';
import 'package:fahem_dashboard/domain/usecases/authentication_admin/reset_admin_password_usecase.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:fahem_dashboard/core/network/firebase_constants.dart';
import 'package:fahem_dashboard/core/resources/routes_manager.dart';
import 'package:fahem_dashboard/core/resources/strings_manager.dart';
import 'package:fahem_dashboard/core/services/notification_service.dart';
import 'package:fahem_dashboard/core/helper/cache_helper.dart';
import 'package:fahem_dashboard/core/utilities/methods.dart';

class AuthenticationProvider with ChangeNotifier {

  late AdminModel _currentAdmin;
  AdminModel get currentAdmin => _currentAdmin;
  setCurrentAdmin(AdminModel adminModel) {
    _currentAdmin = adminModel;
  }
  changeCurrentAdmin(AdminModel adminModel) {
    _currentAdmin = adminModel;
    notifyListeners();
  }

  bool _isLoading = false;
  bool get isLoading => _isLoading;
  changeIsLoading(bool isLoading) {_isLoading = isLoading; notifyListeners();}

  // region Refresh Current Admin
  Future<void> refreshCurrentAdmin() async {
    GetAdminWithIdParameters getAdminWithIdParameters = GetAdminWithIdParameters(adminId: _currentAdmin.adminId);
    Either<Failure, AdminModel> response = await DependencyInjection.getAdminWithIdUseCase.call(getAdminWithIdParameters);
    response.fold((failure) {}, (admin) {
      CacheHelper.setData(key: CacheHelper.currentAdminIdKey, value: admin.adminId);
      changeCurrentAdmin(admin);
    });
  }
  // endregion

  // region Login Admin
  Future<void> loginAdmin({required BuildContext context, required LoginAdminParameters loginAdminParameters}) async {
    changeIsLoading(true);
    Either<Failure, AdminModel> response = await DependencyInjection.loginAdminUseCase.call(loginAdminParameters);
    await response.fold((failure) async {
      changeIsLoading(false);
      await Dialogs.failureOccurred(context: context, failure: failure);
    }, (admin) async {
      CacheHelper.setData(key: CacheHelper.currentAdminIdKey, value: admin.adminId);
      NotificationService.subscribeToTopic(FirebaseConstants.fahemDashboardTopic);
      changeIsLoading(false);
      changeCurrentAdmin(admin);
      Methods.routeTo(context, Routes.splashScreen, isPushReplacement: true);
    });
  }
  // endregion

  // region Reset Password
  Future<void> sendOtpToResetPassword({required BuildContext context, required String emailAddress}) async {
    changeIsLoading(true);
    CheckAdminEmailToResetPasswordParameters checkAdminEmailToResetPasswordParameters = CheckAdminEmailToResetPasswordParameters(
      emailAddress: emailAddress,
    );
    Either<Failure, bool> response = await DependencyInjection.checkAdminEmailToResetPasswordUseCase.call(checkAdminEmailToResetPasswordParameters);
    await response.fold((failure) async {
      changeIsLoading(false);
      await Dialogs.failureOccurred(context: context, failure: failure);
    }, (isAdminEmailExist) async {
      if(isAdminEmailExist) { // Email Exist Then Send OTP To Email
        String verificationCode = Methods.getRandomOtp();
        await EmailService.sendEmail(
          emailAddress: emailAddress,
          subject: Methods.getText(StringsManager.emailSubject),
          message: EmailService.messageTemplate(verificationCode: verificationCode),
        ).then((value) {
          changeIsLoading(false);
          Methods.routeTo(
            context,
            Routes.otpScreen,
            arguments: verificationCode,
            then: ((isSuccess) {
              if(isSuccess != null && isSuccess == true) {
                Methods.routeTo(context, Routes.resetPasswordScreen, arguments: emailAddress);
              }
            }),
          );
        }).catchError((error) {
          changeIsLoading(false);
          Dialogs.showBottomSheetMessage(
            context: context,
            message: Methods.getText(StringsManager.anErrorOccurredTryAgain).toCapitalized(),
          );
        });
      }
      else { // Email Not Exist
        changeIsLoading(false);
        await Dialogs.failureOccurred(
          context: context,
          failure: LocalFailure(
            messageAr: Methods.getTextAr(StringsManager.yourEmailAddressIsNotRegisteredWithUsBefore).toCapitalized(),
            messageEn: Methods.getTextEn(StringsManager.yourEmailAddressIsNotRegisteredWithUsBefore).toCapitalized(),
          ),
        );
      }
    });
  }

  Future<void> resetPassword({required BuildContext context, required ResetAdminPasswordParameters resetAdminPasswordParameters}) async {
    changeIsLoading(true);
    Either<Failure, AdminModel> response = await DependencyInjection.resetAdminPasswordUseCase.call(resetAdminPasswordParameters);
    await response.fold((failure) async {
      changeIsLoading(false);
      await Dialogs.failureOccurred(context: context, failure: failure);
    }, (admin) async {
      CacheHelper.setData(key: CacheHelper.currentAdminIdKey, value: admin.adminId);
      NotificationService.subscribeToTopic(FirebaseConstants.fahemDashboardTopic);
      changeIsLoading(false);
      changeCurrentAdmin(admin);
      Methods.routeTo(context, Routes.mainScreen, isPushNamedAndRemoveUntil: true);
    });
  }
  // endregion

  // region Change Password
  Future<void> changePassword({required BuildContext context, required ChangeAdminPasswordParameters changeAdminPasswordParameters}) async {
    changeIsLoading(true);
    Either<Failure, AdminModel> response = await DependencyInjection.changeAdminPasswordUseCase.call(changeAdminPasswordParameters);
    await response.fold((failure) async {
      changeIsLoading(false);
      await Dialogs.failureOccurred(context: context, failure: failure);
    }, (admin) async {
      changeIsLoading(false);
      changeCurrentAdmin(admin);
      await Dialogs.showBottomSheetMessage(
        context: context,
        message: Methods.getText(StringsManager.thePasswordHasBeenChangedSuccessfully).toCapitalized(),
        showMessage: ShowMessage.success,
        thenMethod: () => Navigator.pop(context),
      );
    });
  }
  // endregion

  // region Logout
  Future<void> logout(BuildContext context) async {
    final InternetConnection internetConnection = InternetConnection();
    await internetConnection.hasInternetAccess.then((value) async {
      if(value) {
        changeIsLoading(true);
        NotificationService.unsubscribeFromTopic(FirebaseConstants.fahemDashboardTopic);
        CacheHelper.removeData(key: CacheHelper.currentAdminIdKey);
        Methods.routeTo(context, Routes.loginScreen, isPushNamedAndRemoveUntil: true);
        await GoogleSignIn().signOut();
        changeIsLoading(false);
      }
      else {
        Methods.showToast(message: Methods.getText(StringsManager.checkYourInternetConnection));
      }
    });
  }
  // endregion

  // region Delete Admin Account
  Future<void> deleteAccount(BuildContext context) async {
    changeIsLoading(true);
    DeleteAdminAccountParameters parameters = DeleteAdminAccountParameters(adminId: MyProviders.authenticationProvider.currentAdmin.adminId);
    Either<Failure, void> response = await DependencyInjection.deleteAdminAccountUseCase.call(parameters);
    await response.fold((failure) async {
      changeIsLoading(false);
      await Dialogs.failureOccurred(context: context, failure: failure);
    }, (_) async {
      await GoogleSignIn().signOut().then((value) {
        NotificationService.unsubscribeFromTopic(FirebaseConstants.fahemDashboardTopic);
        CacheHelper.removeData(key: CacheHelper.currentAdminIdKey);
        changeIsLoading(false);
        Methods.routeTo(context, Routes.loginScreen, isPushNamedAndRemoveUntil: true);
      });
    });
  }
  // endregion
}