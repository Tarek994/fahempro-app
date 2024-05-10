import 'package:flutter/material.dart';
import 'package:fahem/core/error/failure.dart';
import 'package:fahem/core/resources/strings_manager.dart';
import 'package:fahem/core/utilities/dialogs.dart';
import 'package:fahem/core/utilities/methods.dart';

class FirebaseExceptionHandler {

  static Future<void> handleFirebaseException({required BuildContext context, required String code}) async {
    switch (code) {
      case 'invalid-phone-number':
        await Dialogs.failureOccurred(
          context: context,
          failure: LocalFailure(
            messageAr: Methods.getTextAr(StringsManager.phoneNumberIsNotValid),
            messageEn: Methods.getTextEn(StringsManager.phoneNumberIsNotValid),
          ),
        );
        break;
      case 'network-request-failed':
        await Dialogs.failureOccurred(
          context: context,
          failure: LocalFailure(
            messageAr: Methods.getTextAr(StringsManager.networkRequestFailed),
            messageEn: Methods.getTextEn(StringsManager.networkRequestFailed),
          ),
        );
        break;
      case 'invalid-verification-code':
        await Dialogs.failureOccurred(
          context: context,
          failure: LocalFailure(
            messageAr: Methods.getTextAr(StringsManager.theVerificationCodeIsNotValid),
            messageEn: Methods.getTextEn(StringsManager.theVerificationCodeIsNotValid),
          ),
        );
        break;
      case 'invalid-verification-id':
        await Dialogs.failureOccurred(
          context: context,
          failure: LocalFailure(
            messageAr: Methods.getTextAr(StringsManager.theVerificationCodeIsNotValid),
            messageEn: Methods.getTextEn(StringsManager.theVerificationCodeIsNotValid),
          ),
        );
        break;
    }
  }
}