import 'dart:async';
import 'package:dartz/dartz.dart';
import 'package:fahem/core/error/firebase_exception_handler.dart';
import 'package:fahem/core/network/api_constants.dart';
import 'package:fahem/core/resources/constants_manager.dart';
import 'package:fahem/domain/usecases/authentication_user/check_user_exist_with_phone_number_and_get_usecase.dart';
import 'package:fahem/domain/usecases/authentication_user/delete_user_account_usecase.dart';
import 'package:fahem/domain/usecases/authentication_user/is_user_email_exist_usecase.dart';
import 'package:fahem/domain/usecases/authentication_user/register_user_usecase.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:image_picker/image_picker.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:fahem/core/error/failure.dart';
import 'package:fahem/core/services/email_service.dart';
import 'package:fahem/core/utilities/dependency_injection.dart';
import 'package:fahem/core/utilities/dialogs.dart';
import 'package:fahem/core/utilities/enums.dart';
import 'package:fahem/core/utilities/extensions.dart';
import 'package:fahem/core/utilities/my_providers.dart';
import 'package:fahem/data/models/user_model.dart';
import 'package:fahem/domain/usecases/authentication_user/change_user_password_usecase.dart';
import 'package:fahem/domain/usecases/authentication_user/check_user_email_to_reset_password_usecase.dart';
import 'package:fahem/domain/usecases/authentication_user/get_user_with_id_usecase.dart';
import 'package:fahem/domain/usecases/authentication_user/login_user_usecase.dart';
import 'package:fahem/domain/usecases/authentication_user/reset_user_password_usecase.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:fahem/core/network/firebase_constants.dart';
import 'package:fahem/core/resources/routes_manager.dart';
import 'package:fahem/core/resources/strings_manager.dart';
import 'package:fahem/core/services/notification_service.dart';
import 'package:fahem/core/helper/cache_helper.dart';
import 'package:fahem/core/utilities/methods.dart';

class AuthenticationProvider with ChangeNotifier {

  UserModel? _currentUser;
  UserModel? get currentUser => _currentUser;
  setCurrentUser(UserModel? userModel) {
    _currentUser = userModel;
  }
  changeCurrentUser(UserModel? userModel) {
    _currentUser = userModel;
    notifyListeners();
  }

  bool _isLoading = false;
  bool get isLoading => _isLoading;
  changeIsLoading(bool isLoading) {_isLoading = isLoading; notifyListeners();}

  // region Refresh Current User
  Future<void> refreshCurrentUser() async {
    if(_currentUser == null) return;
    GetUserWithIdParameters getUserWithIdParameters = GetUserWithIdParameters(
      userId: _currentUser!.userId,
    );
    Either<Failure, UserModel> response = await DependencyInjection.getUserWithIdUseCase.call(getUserWithIdParameters);
    response.fold((failure) {}, (user) {
      CacheHelper.setData(key: CacheHelper.currentUserIdKey, value: user.userId);
      changeCurrentUser(user);
    });
  }
  // endregion

  // region Register User
  bool _isButtonClicked = false;
  bool get isButtonClicked => _isButtonClicked;
  setIsButtonClicked(bool isButtonClicked) => _isButtonClicked = isButtonClicked;
  changeIsButtonClicked(bool isButtonClicked) {_isButtonClicked = isButtonClicked; notifyListeners();}

  dynamic _personalImage;
  dynamic get personalImage => _personalImage;
  setPersonalImage(dynamic personalImage) => _personalImage = personalImage;
  changePersonalImage(dynamic personalImage) {_personalImage = personalImage; notifyListeners();}

  bool isAllDataValid() {
    // if(_personalImage == null) {
    //   Methods.showToast(message: Methods.getText(StringsManager.personalImageIsRequired).toCapitalized());
    //   return false;
    // }
    return true;
  }

  void resetRegisterScreen() {
    setIsButtonClicked(false);
    setPersonalImage(null);
  }

  Future<void> registerUser({required BuildContext context, required RegisterUserParameters registerUserParameters}) async {
    changeIsLoading(true);
    if(_personalImage is XFile) {
      String? imageName = await Methods.uploadImage(context: context, imagePath: _personalImage.path!, directory: ApiConstants.usersDirectory);
      registerUserParameters.personalImage = imageName!;
    }
    Either<Failure, UserModel> response = await DependencyInjection.registerUserUseCase.call(registerUserParameters);
    await response.fold((failure) async {
      changeIsLoading(false);
      await Dialogs.failureOccurred(context: context, failure: failure);
    }, (user) async {
      changeIsLoading(false);
      CacheHelper.setData(key: CacheHelper.currentUserIdKey, value: user.userId);
      changeCurrentUser(user);
      NotificationService.subscribeToTopic('${FirebaseConstants.userPrefix}${user.userId}');
      Methods.routeTo(context, Routes.mainScreen, isPushNamedAndRemoveUntil: true);

      // Send Notification To Me From Local
      Methods.sendNotificationToUser(
        userId: user.userId,
        title: '${"اهلا"} ${user.fullName}',
        body: 'مرحبا بك فى فاهم نحن سعداء بتواجدك معنا❤️',
        fromLocal: true,
      );
    });
  }
  // endregion

  // region Login User
  Future<void> loginUser({required BuildContext context, required LoginUserParameters loginUserParameters}) async {
    changeIsLoading(true);
    Either<Failure, UserModel> response = await DependencyInjection.loginUserUseCase.call(loginUserParameters);
    await response.fold((failure) async {
      changeIsLoading(false);
      await Dialogs.failureOccurred(context: context, failure: failure);
    }, (user) async {
      changeIsLoading(false);
      CacheHelper.setData(key: CacheHelper.currentUserIdKey, value: user.userId);
      changeCurrentUser(user);
      NotificationService.subscribeToTopic('${FirebaseConstants.userPrefix}${user.userId}');
      Methods.routeTo(context, Routes.mainScreen, isPushReplacement: true);
    });
  }
  // endregion

  // region Sign In With Google
  Future<void> signInWithGoogle({required BuildContext context}) async {
    changeIsLoading(true);
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
    if(googleUser != null) {
      IsUserEmailExistParameters isUserEmailExistParameters = IsUserEmailExistParameters(
        emailAddress: googleUser.email,
      );
      Either<Failure, bool> response = await DependencyInjection.isUserEmailExistUseCase.call(isUserEmailExistParameters);
      await response.fold((failure) async {
        changeIsLoading(false);
        await Dialogs.failureOccurred(context: context, failure: failure);
      }, (isUserEmailExist) async {
        if(isUserEmailExist) {
          // Login
          LoginUserParameters loginUserParameters = LoginUserParameters(
            emailAddress: googleUser.email,
            password: googleUser.id,
          );
          loginUser(context: context, loginUserParameters: loginUserParameters);
        }
        else {
          // Register
          // RegisterUserParameters registerUserParameters = RegisterUserParameters(
          //   fullName: googleUser.displayName ?? 'الاسم',
          //   personalImage: googleUser.photoUrl,
          //   emailAddress: googleUser.email,
          //   password: googleUser.id,
          //   signInMethod: SignInMethod.google,
          //   createdAt: DateTime.now().millisecondsSinceEpoch.toString(),
          // );
          // await registerUser(context: context, registerUserParameters: registerUserParameters);
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
    CheckUserEmailToResetPasswordParameters checkUserEmailToResetPasswordParameters = CheckUserEmailToResetPasswordParameters(
      emailAddress: emailAddress,
    );
    Either<Failure, bool> response = await DependencyInjection.checkUserEmailToResetPasswordUseCase.call(checkUserEmailToResetPasswordParameters);
    await response.fold((failure) async {
      changeIsLoading(false);
      await Dialogs.failureOccurred(context: context, failure: failure);
    }, (isUserEmailExist) async {
      if(isUserEmailExist) { // Email Exist Then Send OTP To Email
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

  Future<void> resetPassword({required BuildContext context, required ResetUserPasswordParameters resetUserPasswordParameters}) async {
    changeIsLoading(true);
    Either<Failure, UserModel> response = await DependencyInjection.resetUserPasswordUseCase.call(resetUserPasswordParameters);
    await response.fold((failure) async {
      changeIsLoading(false);
      await Dialogs.failureOccurred(context: context, failure: failure);
    }, (user) async {
      changeIsLoading(false);
      CacheHelper.setData(key: CacheHelper.currentUserIdKey, value: user.userId);
      changeCurrentUser(user);
      NotificationService.subscribeToTopic('${FirebaseConstants.userPrefix}${user.userId}');
      Methods.routeTo(context, Routes.mainScreen, isPushNamedAndRemoveUntil: true);
    });
  }
  // endregion

  // region Change Password
  Future<void> changePassword({required BuildContext context, required ChangeUserPasswordParameters changeUserPasswordParameters}) async {
    changeIsLoading(true);
    Either<Failure, UserModel> response = await DependencyInjection.changeUserPasswordUseCase.call(changeUserPasswordParameters);
    await response.fold((failure) async {
      changeIsLoading(false);
      await Dialogs.failureOccurred(context: context, failure: failure);
    }, (user) async {
      changeIsLoading(false);
      changeCurrentUser(user);
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
        NotificationService.unsubscribeFromTopic(FirebaseConstants.fahemTopic);
        NotificationService.unsubscribeFromTopic('${FirebaseConstants.userPrefix}${MyProviders.authenticationProvider.currentUser!.userId}');
        CacheHelper.removeData(key: CacheHelper.currentUserIdKey);
        Methods.routeTo(context, Routes.loginWithPhoneScreen, isPushNamedAndRemoveUntil: true);
        await GoogleSignIn().signOut();
        changeIsLoading(false);
      }
      else {
        Methods.showToast(message: Methods.getText(StringsManager.checkYourInternetConnection));
      }
    });
  }
  // endregion

  // region Delete User User
  Future<void> deleteUser(BuildContext context) async {
    changeIsLoading(true);
    DeleteUserAccountParameters parameters = DeleteUserAccountParameters(userId: MyProviders.authenticationProvider.currentUser!.userId);
    Either<Failure, void> response = await DependencyInjection.deleteUserAccountUseCase.call(parameters);
    await response.fold((failure) async {
      changeIsLoading(false);
      await Dialogs.failureOccurred(context: context, failure: failure);
    }, (_) async {
      await GoogleSignIn().signOut().then((value) {
        NotificationService.unsubscribeFromTopic(FirebaseConstants.fahemTopic);
        NotificationService.unsubscribeFromTopic('${FirebaseConstants.userPrefix}${MyProviders.authenticationProvider.currentUser!.userId}');
        CacheHelper.removeData(key: CacheHelper.currentUserIdKey);
        changeIsLoading(false);
        Methods.routeTo(context, Routes.loginWithPhoneScreen, isPushNamedAndRemoveUntil: true);
      });
    });
  }
  // endregion

  // region Authentication With Phone Number
  bool isVerified = false;

  Timer? _timer;
  int? _resendCodeTimer;
  int? get resendCodeTimer => _resendCodeTimer;
  changeResendCodeTimer(int? resendCodeTimer) {_resendCodeTimer = resendCodeTimer; notifyListeners();}

  void startResendCodeTimer() {
    _timer?.cancel();
    _resendCodeTimer = ConstantsManager.resendCodeDuration;
    _timer = Timer.periodic(const Duration(seconds: 1), (Timer timer) {
      if(timer.isActive && _resendCodeTimer != null) {
        if (_resendCodeTimer! <= 0) {timer.cancel();}
        else {_resendCodeTimer = _resendCodeTimer! - 1;}
        notifyListeners();
      }
    });
  }

  Future<void> sendOtpToVerifyPhone({required BuildContext context, required String phoneNumber}) async {
    if(_resendCodeTimer == 0) {changeResendCodeTimer(null);}
    if(resendCodeTimer == null) {
      final InternetConnection internetConnection = InternetConnection();
      await internetConnection.hasInternetAccess.then((isConnected) async {
        if(isConnected) {
          try {
            changeIsLoading(true);
            await FirebaseAuth.instance.verifyPhoneNumber(
              timeout: const Duration(seconds: ConstantsManager.resendCodeDuration),
              phoneNumber: '${ConstantsManager.dialingCodeEgypt}$phoneNumber',
              verificationCompleted: (phoneAuthCredential) => _onVerificationCompleted(phoneAuthCredential),
              verificationFailed: (error) => _onVerificationFailed(error, context),
              codeSent: (verificationId, forceResendingToken) => _onCodeSent(verificationId, forceResendingToken, context, phoneNumber),
              codeAutoRetrievalTimeout: (verificationId) => _onCodeAutoRetrievalTimeout(verificationId),
            );
          }
          catch (error) {
            Dialogs.failureOccurred(
              context: context,
              failure: LocalFailure(
                  messageAr: Methods.getTextAr(StringsManager.anErrorOccurredTryAgain),
                  messageEn: Methods.getTextEn(StringsManager.anErrorOccurredTryAgain),
                ),
            );
          }
        }
        else {
          Dialogs.failureOccurred(
            context: context,
            failure: LocalFailure(
              messageAr: Methods.getTextAr(StringsManager.checkYourInternetConnection),
              messageEn: Methods.getTextEn(StringsManager.checkYourInternetConnection),
            ),
          );
        }
      });
    }
  }

  _onVerificationCompleted(phoneAuthCredential) {
    changeIsLoading(false);
    debugPrint('verificationCompleted');
  }
  _onVerificationFailed(error, context) async {
    if(error.message != null) {
      Dialogs.failureOccurred(
        context: context,
        failure: LocalFailure(messageAr: error.message!, messageEn: error.message!),
        // bottomSheetClosedDuration: 5,
      );
    }
    changeIsLoading(false);
    debugPrint('verificationFailed: $error');
    await FirebaseExceptionHandler.handleFirebaseException(context: context, code: error.code);
  }
  _onCodeSent(verificationId, forceResendingToken, context, phoneNumber) async {
    changeIsLoading(false);
    debugPrint('codeSent');
    startResendCodeTimer();
    await Methods.routeTo(
        context,
        Routes.verifyPhoneOtpScreen,
        arguments: {
          ConstantsManager.verificationIdArgument: verificationId,
          ConstantsManager.phoneNumberArgument: phoneNumber,
        },
        then: (isSuccess) async {
          if(isSuccess != null && isSuccess == true) {
            isVerified = true;
            await loginOrRegisterWithPhoneNumber(context: context, phoneNumber: phoneNumber);
          }
        }
    );
  }
  _onCodeAutoRetrievalTimeout(verificationId) {
    changeIsLoading(false);
    debugPrint('codeAutoRetrievalTimeout');
  }

  Future<bool?> verifyOtp({required BuildContext context, required String verificationId, required String phoneNumber, required String otpCode}) async {
    bool? result;
    final InternetConnection internetConnection = InternetConnection();
    await internetConnection.hasInternetAccess.then((isConnected) async {
      if(isConnected) {
        try {
          changeIsLoading(true);
          PhoneAuthCredential phoneAuthCredential = PhoneAuthProvider.credential(verificationId: verificationId, smsCode: otpCode);
          await FirebaseAuth.instance.signInWithCredential(phoneAuthCredential).then((value) async {
            result = true;
          });
          changeIsLoading(false);
        }
        on FirebaseAuthException catch (error) {
          changeIsLoading(false);
          await FirebaseExceptionHandler.handleFirebaseException(context: context, code: error.code);
        }
        catch (error) {
          changeIsLoading(false);
          Dialogs.failureOccurred(
            context: context,
            failure: LocalFailure(
              messageAr: Methods.getTextAr(StringsManager.anErrorOccurredTryAgain),
              messageEn: Methods.getTextEn(StringsManager.anErrorOccurredTryAgain),
            ),
          );
        }
      }
      else {
        Dialogs.failureOccurred(
          context: context,
          failure: LocalFailure(
            messageAr: Methods.getTextAr(StringsManager.checkYourInternetConnection),
            messageEn: Methods.getTextEn(StringsManager.checkYourInternetConnection),
          ),
        );
      }
    });
    return Future.value(result);
  }

  Future<void> loginOrRegisterWithPhoneNumber({required BuildContext context, required String phoneNumber}) async {
    changeIsLoading(true);
    CheckUserExistWithPhoneNumberAndGetParameters parameters = CheckUserExistWithPhoneNumberAndGetParameters(
      phoneNumber: phoneNumber,
    );
    Either<Failure, UserModel?> response = await DependencyInjection.checkUserExistWithPhoneNumberAndGetUseCase.call(parameters);
    await response.fold((failure) async {
      changeIsLoading(false);
      await Dialogs.failureOccurred(context: context, failure: failure);
    }, (user) async {
      changeIsLoading(false);
      if(user == null) { // User Not Exist Then Go To Register Screen
        Methods.routeTo(context, Routes.registerWithPhoneScreen, arguments: phoneNumber);
      }
      else { // User Exist Then Go To Splash Screen
        changeIsLoading(false);
        CacheHelper.setData(key: CacheHelper.currentUserIdKey, value: user.userId);
        changeCurrentUser(user);
        NotificationService.subscribeToTopic('${FirebaseConstants.userPrefix}${user.userId}');
        Methods.routeTo(context, Routes.mainScreen, isPushNamedAndRemoveUntil: true);
      }
    });
  }
  // endregion
}