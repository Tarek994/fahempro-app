import 'package:fahem_business/core/resources/strings_manager.dart';
import 'package:fahem_business/core/utilities/extensions.dart';
import 'package:fahem_business/core/utilities/methods.dart';

class Validator {

  static String? validateEmpty(String? value) {
    value = value!.trim();
    if(value.isEmpty) {
      return Methods.getText(StringsManager.required).toCapitalized();
    }
    return null;
  }

  static String? validateVersion(String? value) {
    value = value!.trim();
    RegExp versionRegExp = RegExp(r'\d+\.\d+\.\d+');
    if(value.isEmpty) {
      return Methods.getText(StringsManager.required).toCapitalized();
    }
    else if(!versionRegExp.hasMatch(value)) {
      return Methods.getText(StringsManager.theVersionFormatIsIncorrect).toCapitalized();
    }
    return null;
  }

  static String? validateIntegerNumber(String? value) {
    value = value!.trim();
    RegExp integerNumberRegExp = RegExp(r'^[0-9]*$');
    if(value.isEmpty) {
      return Methods.getText(StringsManager.required).toCapitalized();
    }
    else if(!integerNumberRegExp.hasMatch(value)) {
      return Methods.getText(StringsManager.onlyNumbersAreAllowed).toCapitalized();
    }
    return null;
  }

  static String? validateIntegerNumberAllowEmpty(String? value) {
    value = value!.trim();
    RegExp integerNumberRegExp = RegExp(r'^[0-9]*$');
    if(value.isNotEmpty) {
      if(!integerNumberRegExp.hasMatch(value)) {
        return Methods.getText(StringsManager.onlyNumbersAreAllowed).toCapitalized();
      }
    }
    return null;
  }

  static String? validateIntegerNumberAllowEmptyAllowMax(String? value, int maxNumber) {
    value = value!.trim();
    RegExp integerNumberRegExp = RegExp(r'^[0-9]*$');
    if(value.isNotEmpty) {
      if(!integerNumberRegExp.hasMatch(value)) {
        return Methods.getText(StringsManager.onlyNumbersAreAllowed).toCapitalized();
      }
      else if(int.parse(value) > maxNumber) {
        return '${Methods.getText(StringsManager.typeNumberLessThanOrEqualTo).toCapitalized()} $maxNumber';
      }
    }
    return null;
  }

  static String? validateIntegerNumberAllowMax(String? value, int maxNumber) {
    value = value!.trim();
    RegExp integerNumberRegExp = RegExp(r'^[0-9]*$');
    if(value.isEmpty) {
      return Methods.getText(StringsManager.required).toCapitalized();
    }
    if(!integerNumberRegExp.hasMatch(value)) {
      return Methods.getText(StringsManager.onlyNumbersAreAllowed).toCapitalized();
    }
    else if(int.parse(value) > maxNumber) {
      return '${Methods.getText(StringsManager.typeNumberLessThanOrEqualTo).toCapitalized()} $maxNumber';
    }
    return null;
  }

  static String? validateIntegerNumberNotAllowEmptyNotAllowZeroAllowMax(String? value, int maxNumber) {
    value = value!.trim();
    RegExp integerNumberRegExp = RegExp(r'^[0-9]*$');
    if(value.isEmpty) {
      return Methods.getText(StringsManager.required).toCapitalized();
    }
    else if(!integerNumberRegExp.hasMatch(value)) {
      return Methods.getText(StringsManager.onlyNumbersAreAllowed).toCapitalized();
    }
    else if(int.parse(value) > maxNumber) {
      return '${Methods.getText(StringsManager.typeNumberLessThanOrEqualTo).toCapitalized()} $maxNumber';
    }
    else if(value == '0') {
      return Methods.getText(StringsManager.zeroValueIsNotAllowed).toCapitalized();
    }
    return null;
  }

  static String? validateIntegerNumberNotAllowZero(String? value) {
    value = value!.trim();
    RegExp integerNumberRegExp = RegExp(r'^[0-9]*$');
    if(value.isEmpty) {
      return Methods.getText(StringsManager.required).toCapitalized();
    }
    else if(!integerNumberRegExp.hasMatch(value)) {
      return Methods.getText(StringsManager.onlyNumbersAreAllowed).toCapitalized();
    }
    else if(value == '0') {
      return Methods.getText(StringsManager.zeroValueIsNotAllowed).toCapitalized();
    }
    return null;
  }

  static String? validateIntegerNumberAllowEmptyNotAllowZero(String? value) {
    value = value!.trim();
    RegExp integerNumberRegExp = RegExp(r'^[0-9]*$');
    if(value.isNotEmpty) {
      if(!integerNumberRegExp.hasMatch(value)) {
        return Methods.getText(StringsManager.onlyNumbersAreAllowed).toCapitalized();
      }
      else if(value == '0') {
        return Methods.getText(StringsManager.zeroValueIsNotAllowed).toCapitalized();
      }
    }
    return null;
  }

  static String? validatePercentage(String? value) {
    value = value!.trim();
    RegExp integerNumberRegExp = RegExp(r'^[0-9]*$');
    if(value.isEmpty) {
      return Methods.getText(StringsManager.required).toCapitalized();
    }
    else if(!integerNumberRegExp.hasMatch(value)) {
      return Methods.getText(StringsManager.onlyNumbersAreAllowed).toCapitalized();
    }
    else if(int.parse(value) < 1 || int.parse(value) > 100) {
      return Methods.getText(StringsManager.typeNumberBetween1And100).toCapitalized();
    }
    return null;
  }

  static String? validatePercentageAllowEmpty(String? value) {
    value = value!.trim();
    RegExp integerNumberRegExp = RegExp(r'^[0-9]*$');
    if(value.isNotEmpty) {
      if(!integerNumberRegExp.hasMatch(value)) {
        return Methods.getText(StringsManager.onlyNumbersAreAllowed).toCapitalized();
      }
      else if(int.parse(value) < 1 || int.parse(value) > 100) {
        return Methods.getText(StringsManager.typeNumberBetween1And100).toCapitalized();
      }
    }
    return null;
  }

  static String? validateEmailAddress(String? value) {
    value = value!.trim();
    RegExp emailAddressRegExp = RegExp(r'\S+@\S+\.\S+');
    if(value.isEmpty) {
      return Methods.getText(StringsManager.required).toCapitalized();
    }
    else if(!emailAddressRegExp.hasMatch(value)) {
      return Methods.getText(StringsManager.emailAddressIsNotValid).toCapitalized();
    }
    return null;
  }

  static String? validateEmailAddressAllowEmpty(String? value) {
    value = value!.trim();
    RegExp emailAddressRegExp = RegExp(r'\S+@\S+\.\S+');
    if(value.isNotEmpty) {
      if(!emailAddressRegExp.hasMatch(value)) {
        return Methods.getText(StringsManager.emailAddressIsNotValid).toCapitalized();
      }
    }
    return null;
  }

  static String? validatePasswordLength(String? value) {
    if(value!.isEmpty) {
      return Methods.getText(StringsManager.required).toCapitalized();
    }
    else if(value.length < 6) {
      return Methods.getText(StringsManager.passwordMustNotBeLessThan6Characters).toCapitalized();
    }
    return null;
  }

  static String? validateConfirmPassword(String? value, String firstPassword) {
    if(value!.isEmpty) {
      return Methods.getText(StringsManager.required).toCapitalized();
    }
    else if(value.length < 6) {
      return Methods.getText(StringsManager.passwordMustNotBeLessThan6Characters).toCapitalized();
    }
    else if(value != firstPassword) {
      return Methods.getText(StringsManager.passwordDoesNotMatch).toCapitalized();
    }
    return null;
  }

  static String? validatePhoneNumber(String? value) {
    value = value!.trim();
    RegExp integerNumberRegExp = RegExp(r'^[0-9]*$');
    if(value.isEmpty) {
      return Methods.getText(StringsManager.required).toCapitalized();
    }
    else if(!integerNumberRegExp.hasMatch(value)) {
      return Methods.getText(StringsManager.onlyNumbersAreAllowed).toCapitalized();
    }
    else if(!value.startsWith('010') && !value.startsWith('011') && !value.startsWith('012') && !value.startsWith('015')) {
      return Methods.getText(StringsManager.phoneNumberNotValid).toCapitalized();
    }
    else if(value.length != 11) {
      return Methods.getText(StringsManager.phoneNumberNotValid).toCapitalized();
    }
    return null;
  }

  static String? validatePhoneNumberAllowEmpty(String? value) {
    value = value!.trim();
    RegExp integerNumberRegExp = RegExp(r'^[0-9]*$');
    if(value.isNotEmpty) {
      if(!integerNumberRegExp.hasMatch(value)) {
        return Methods.getText(StringsManager.onlyNumbersAreAllowed).toCapitalized();
      }
      else if(!value.startsWith('010') && !value.startsWith('011') && !value.startsWith('012') && !value.startsWith('015')) {
        return Methods.getText(StringsManager.phoneNumberNotValid).toCapitalized();
      }
      else if(value.length != 11) {
        return Methods.getText(StringsManager.phoneNumberNotValid).toCapitalized();
      }
    }
    return null;
  }

  static String? validateLink(String? value) {
    value = value!.trim();
    if(value.isEmpty) {
      return Methods.getText(StringsManager.required).toCapitalized();
    }
    else if(!Uri.parse(value).isAbsolute) {
      return Methods.getText(StringsManager.theLinkFormatIsIncorrect).toCapitalized();
    }
    return null;
  }

  static String? validateLinkAllowEmpty(String? value) {
    value = value!.trim();
    if(value.isNotEmpty) {
      if(!Uri.parse(value).isAbsolute) {
        return Methods.getText(StringsManager.theLinkFormatIsIncorrect).toCapitalized();
      }
    }
    return null;
  }

  static String? validateDiscountPriceAllowEmpty(String? value, String originalPrice) {
    value = value!.trim();
    originalPrice = originalPrice.trim();
    RegExp integerNumberRegExp = RegExp(r'^[0-9]*$');
    if(value.isNotEmpty) {
      if(!integerNumberRegExp.hasMatch(value)) {
        return Methods.getText(StringsManager.onlyNumbersAreAllowed).toCapitalized();
      }
      if(originalPrice.isNotEmpty && int.parse(originalPrice) < int.parse(value)) {
        return Methods.getText(StringsManager.mustDiscountPriceLessOriginalPrice);
      }
    }
    return null;
  }

  // Validate Dropdown
  static String? validateEmptyDropdown(Object? value) {
    if(value == null) {
      return Methods.getText(StringsManager.required).toCapitalized();
    }
    return null;
  }
}