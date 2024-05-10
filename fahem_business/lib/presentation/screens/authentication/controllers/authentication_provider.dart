import 'package:dartz/dartz.dart';
import 'package:fahem_business/core/network/api_constants.dart';
import 'package:fahem_business/data/models/main_category_model.dart';
import 'package:fahem_business/domain/usecases/authentication_account/is_account_email_exist_usecase.dart';
import 'package:fahem_business/domain/usecases/authentication_account/register_account_usecase.dart';
import 'package:image_picker/image_picker.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:fahem_business/core/error/failure.dart';
import 'package:fahem_business/core/services/email_service.dart';
import 'package:fahem_business/core/utilities/dependency_injection.dart';
import 'package:fahem_business/core/utilities/dialogs.dart';
import 'package:fahem_business/core/utilities/enums.dart';
import 'package:fahem_business/core/utilities/extensions.dart';
import 'package:fahem_business/core/utilities/my_providers.dart';
import 'package:fahem_business/data/models/account_model.dart';
import 'package:fahem_business/domain/usecases/authentication_account/change_account_password_usecase.dart';
import 'package:fahem_business/domain/usecases/authentication_account/check_account_email_to_reset_password_usecase.dart';
import 'package:fahem_business/domain/usecases/authentication_account/delete_account_account_usecase.dart';
import 'package:fahem_business/domain/usecases/authentication_account/get_account_with_id_usecase.dart';
import 'package:fahem_business/domain/usecases/authentication_account/login_account_usecase.dart';
import 'package:fahem_business/domain/usecases/authentication_account/reset_account_password_usecase.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:fahem_business/core/network/firebase_constants.dart';
import 'package:fahem_business/core/resources/routes_manager.dart';
import 'package:fahem_business/core/resources/strings_manager.dart';
import 'package:fahem_business/core/services/notification_service.dart';
import 'package:fahem_business/core/helper/cache_helper.dart';
import 'package:fahem_business/core/utilities/methods.dart';

class AuthenticationProvider with ChangeNotifier {

  late AccountModel _currentAccount;
  AccountModel get currentAccount => _currentAccount;
  setCurrentAccount(AccountModel accountModel) {
    _currentAccount = accountModel;
  }
  changeCurrentAccount(AccountModel accountModel) {
    _currentAccount = accountModel;
    notifyListeners();
  }

  bool _isLoading = false;
  bool get isLoading => _isLoading;
  changeIsLoading(bool isLoading) {_isLoading = isLoading; notifyListeners();}

  // region Refresh Current Account
  Future<void> refreshCurrentAccount() async {
    GetAccountWithIdParameters getAccountWithIdParameters = GetAccountWithIdParameters(accountId: _currentAccount.accountId);
    Either<Failure, AccountModel> response = await DependencyInjection.getAccountWithIdUseCase.call(getAccountWithIdParameters);
    response.fold((failure) {}, (account) {
      CacheHelper.setData(key: CacheHelper.currentAccountIdKey, value: account.accountId);
      changeCurrentAccount(account);
    });
  }
  // endregion

  // region Register Account
  bool _isButtonClicked = false;
  bool get isButtonClicked => _isButtonClicked;
  setIsButtonClicked(bool isButtonClicked) => _isButtonClicked = isButtonClicked;
  changeIsButtonClicked(bool isButtonClicked) {_isButtonClicked = isButtonClicked; notifyListeners();}

  MainCategoryModel? _mainCategory;
  MainCategoryModel? get mainCategory => _mainCategory;
  setMainCategory(MainCategoryModel? mainCategory) => _mainCategory = mainCategory;
  changeMainCategory(MainCategoryModel? mainCategory) {_mainCategory = mainCategory; notifyListeners();}

  dynamic _personalImage;
  dynamic get personalImage => _personalImage;
  setPersonalImage(dynamic personalImage) => _personalImage = personalImage;
  changePersonalImage(dynamic personalImage) {_personalImage = personalImage; notifyListeners();}

  bool isAllDataValid() {
    if(_mainCategory == null) {
      Methods.showToast(message: Methods.getText(StringsManager.chooseMainCategory).toCapitalized());
      return false;
    }
    // if(_personalImage == null) {
    //   Methods.showToast(message: Methods.getText(StringsManager.personalImageIsRequired).toCapitalized());
    //   return false;
    // }
    return true;
  }

  void resetRegisterScreen() {
    setIsButtonClicked(false);
    setMainCategory(null);
    setPersonalImage(null);
  }

  Future<void> registerAccount({required BuildContext context, required RegisterAccountParameters registerAccountParameters}) async {
    changeIsLoading(true);
    if(_personalImage is XFile) {
      String? imageName = await Methods.uploadImage(context: context, imagePath: _personalImage.path!, directory: ApiConstants.accountsDirectory);
      registerAccountParameters.personalImage = imageName!;
    }
    Either<Failure, AccountModel> response = await DependencyInjection.registerAccountUseCase.call(registerAccountParameters);
    await response.fold((failure) async {
      changeIsLoading(false);
      await Dialogs.failureOccurred(context: context, failure: failure);
    }, (account) async {
      changeIsLoading(false);
      CacheHelper.setData(key: CacheHelper.currentAccountIdKey, value: account.accountId);
      changeCurrentAccount(account);
      NotificationService.subscribeToTopic('${FirebaseConstants.accountPrefix}${account.accountId}');
      Methods.routeTo(context, Routes.mainScreen, isPushNamedAndRemoveUntil: true);

      // Send Notification To Me From Local
      Methods.sendNotificationToBusiness(
        accountId: account.accountId,
        title: '${"اهلا"} ${account.fullName}',
        body: 'مرحبا بك فى فاهم نحن سعداء بتواجدك معنا❤️',
        fromLocal: true,
      );
    });
  }
  // endregion

  // region Login Account
  Future<void> loginAccount({required BuildContext context, required LoginAccountParameters loginAccountParameters}) async {
    changeIsLoading(true);
    Either<Failure, AccountModel> response = await DependencyInjection.loginAccountUseCase.call(loginAccountParameters);
    await response.fold((failure) async {
      changeIsLoading(false);
      await Dialogs.failureOccurred(context: context, failure: failure);
    }, (account) async {
      changeIsLoading(false);
      CacheHelper.setData(key: CacheHelper.currentAccountIdKey, value: account.accountId);
      changeCurrentAccount(account);
      NotificationService.subscribeToTopic('${FirebaseConstants.accountPrefix}${account.accountId}');
      Methods.routeTo(context, Routes.splashScreen, isPushReplacement: true);
    });
  }
  // endregion

  // region Sign In With Google
  Future<void> signInWithGoogle({required BuildContext context}) async {
    changeIsLoading(true);
    final GoogleSignInAccount? googleAccount = await GoogleSignIn().signIn();
    if(googleAccount != null) {
      IsAccountEmailExistParameters isAccountEmailExistParameters = IsAccountEmailExistParameters(
        emailAddress: googleAccount.email,
      );
      Either<Failure, bool> response = await DependencyInjection.isAccountEmailExistUseCase.call(isAccountEmailExistParameters);
      await response.fold((failure) async {
        changeIsLoading(false);
        await Dialogs.failureOccurred(context: context, failure: failure);
      }, (isAccountEmailExist) async {
        if(isAccountEmailExist) {
          // Login
          LoginAccountParameters loginAccountParameters = LoginAccountParameters(
            emailAddress: googleAccount.email,
            password: googleAccount.id,
          );
          loginAccount(context: context, loginAccountParameters: loginAccountParameters);
        }
        else {
          // Register
          await Dialogs.mainCategoriesBottomSheet(context: context).then((value) async {
            if(value != null) {
              RegisterAccountParameters registerAccountParameters = RegisterAccountParameters(
                mainCategoryId: value.mainCategoryId,
                fullName: googleAccount.displayName ?? 'الاسم',
                personalImage: googleAccount.photoUrl,
                emailAddress: googleAccount.email,
                password: googleAccount.id,
                signInMethod: SignInMethod.google,
                createdAt: DateTime.now().millisecondsSinceEpoch.toString(),
              );
              await registerAccount(context: context, registerAccountParameters: registerAccountParameters);
            }
            changeIsLoading(false);
          });
        }
      });
    }
    else {
      await GoogleSignIn().signOut();
      changeIsLoading(false);
    }
  }
  // endregion

  // region Reset Password
  Future<void> sendOtpToResetPassword({required BuildContext context, required String emailAddress}) async {
    changeIsLoading(true);
    CheckAccountEmailToResetPasswordParameters checkAccountEmailToResetPasswordParameters = CheckAccountEmailToResetPasswordParameters(
      emailAddress: emailAddress,
    );
    Either<Failure, bool> response = await DependencyInjection.checkAccountEmailToResetPasswordUseCase.call(checkAccountEmailToResetPasswordParameters);
    await response.fold((failure) async {
      changeIsLoading(false);
      await Dialogs.failureOccurred(context: context, failure: failure);
    }, (isAccountEmailExist) async {
      if(isAccountEmailExist) { // Email Exist Then Send OTP To Email
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

  Future<void> resetPassword({required BuildContext context, required ResetAccountPasswordParameters resetAccountPasswordParameters}) async {
    changeIsLoading(true);
    Either<Failure, AccountModel> response = await DependencyInjection.resetAccountPasswordUseCase.call(resetAccountPasswordParameters);
    await response.fold((failure) async {
      changeIsLoading(false);
      await Dialogs.failureOccurred(context: context, failure: failure);
    }, (account) async {
      changeIsLoading(false);
      CacheHelper.setData(key: CacheHelper.currentAccountIdKey, value: account.accountId);
      changeCurrentAccount(account);
      NotificationService.subscribeToTopic('${FirebaseConstants.accountPrefix}${account.accountId}');
      Methods.routeTo(context, Routes.mainScreen, isPushNamedAndRemoveUntil: true);
    });
  }
  // endregion

  // region Change Password
  Future<void> changePassword({required BuildContext context, required ChangeAccountPasswordParameters changeAccountPasswordParameters}) async {
    changeIsLoading(true);
    Either<Failure, AccountModel> response = await DependencyInjection.changeAccountPasswordUseCase.call(changeAccountPasswordParameters);
    await response.fold((failure) async {
      changeIsLoading(false);
      await Dialogs.failureOccurred(context: context, failure: failure);
    }, (account) async {
      changeIsLoading(false);
      changeCurrentAccount(account);
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
        NotificationService.unsubscribeFromTopic(FirebaseConstants.fahemBusinessTopic);
        NotificationService.unsubscribeFromTopic('${FirebaseConstants.accountPrefix}${MyProviders.authenticationProvider.currentAccount.accountId}');
        CacheHelper.removeData(key: CacheHelper.currentAccountIdKey);
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

  // region Delete Account Account
  Future<void> deleteAccount(BuildContext context) async {
    changeIsLoading(true);
    DeleteAccountAccountParameters parameters = DeleteAccountAccountParameters(accountId: MyProviders.authenticationProvider.currentAccount.accountId);
    Either<Failure, void> response = await DependencyInjection.deleteAccountAccountUseCase.call(parameters);
    await response.fold((failure) async {
      changeIsLoading(false);
      await Dialogs.failureOccurred(context: context, failure: failure);
    }, (_) async {
      await GoogleSignIn().signOut().then((value) {
        NotificationService.unsubscribeFromTopic(FirebaseConstants.fahemBusinessTopic);
        NotificationService.unsubscribeFromTopic('${FirebaseConstants.accountPrefix}${MyProviders.authenticationProvider.currentAccount.accountId}');
        CacheHelper.removeData(key: CacheHelper.currentAccountIdKey);
        changeIsLoading(false);
        Methods.routeTo(context, Routes.loginScreen, isPushNamedAndRemoveUntil: true);
      });
    });
  }
  // endregion
}