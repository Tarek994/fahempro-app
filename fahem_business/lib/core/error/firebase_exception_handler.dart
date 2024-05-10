import 'package:flutter/material.dart';
import 'package:fahem_business/core/error/failure.dart';
import 'package:fahem_business/core/resources/strings_manager.dart';
import 'package:fahem_business/core/utilities/dialogs.dart';
import 'package:fahem_business/core/utilities/methods.dart';

class FirebaseExceptionHandler {

  static void handleFirebaseException({required BuildContext context, required String code}) {
    switch (code) {
      case 'invalid-phone-number':
        Dialogs.failureOccurred(context: context, failure: LocalFailure(messageAr: Methods.getTextAr(StringsManager.phoneNumberIsNotValid), messageEn: Methods.getTextEn(StringsManager.phoneNumberIsNotValid)));
        break;
      case 'network-request-failed':
        Dialogs.failureOccurred(context: context, failure: LocalFailure(messageAr: Methods.getTextAr(StringsManager.networkRequestFailed), messageEn: Methods.getTextEn(StringsManager.networkRequestFailed)));
        break;
      case 'invalid-verification-code':
        Dialogs.failureOccurred(context: context, failure: LocalFailure(messageAr: Methods.getTextAr(StringsManager.theVerificationCodeIsNotValid), messageEn: Methods.getTextEn(StringsManager.theVerificationCodeIsNotValid)));
        break;
      case 'invalid-verification-id':
        Dialogs.failureOccurred(context: context, failure: LocalFailure(messageAr: Methods.getTextAr(StringsManager.theVerificationCodeIsNotValid), messageEn: Methods.getTextEn(StringsManager.theVerificationCodeIsNotValid)));
        break;
    }
  }
}