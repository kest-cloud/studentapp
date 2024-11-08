enum ValidateFailResult {
  empty,
  invalidEmail,
  invalidPassword,
  passwordNotMatch,
  invalidAtLeastSixCharacter,
  invalidPhoneNumber,
  invalidLength,
  invalidPasswordType,
  isNewPasswordMatchOldPassword,
  isNewPwdAndConfirmedPwdNotMatched,
  isAccountNumberInvalid,
}

typedef Validator = ValidateFailResult? Function(String?);
typedef ValidatorString = String? Function(String?);
typedef ValidatorsString = Function(String?);

mixin InputValidationMixin {
  final hasNumberRegEx = RegExp(r'[0-9]+');
  final hasCharacterRegEx =
      RegExp(r'^(?=.*[A-Za-z])(?=.*\d)(?=.*[@$!%*#?&])[A-Za-z\d@$!%*#?&]{8,}$');

  // Regular expression for a 4-digit PIN with consecutive digits
  RegExp ascendingRegex =
      RegExp(r'^(?!1234|2345|3456|4567|5678|6789|7890)\d{4}$');
  RegExp descendingRegex =
      RegExp(r'^(?!4321|5432|6543|7654|8765|9876|0987)\d{4}$');

  final isNumber = RegExp(r'[^0-9]{1,}');
  final isEmailRegEx = RegExp(
    r"^[a-zA-Z0-9.!#$%&'.*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?).*$",
  );
  final isPhoneNumber = RegExp(
    r'^(016|086|096|097|098|032|033|034|035|036|037|038|039|090|093|0120|0121|0122|0126|0128|0896|091|70|90|60|80|094|083|084|085|081|082|092|056|058|099|059|0296|0254|0209|0204|0291|0222|0275|0256|0274|0271|0252|0290|0292|0206|0236|0262|0261|0215|0251|0277|0269|0226|024|0239|0220|0225|0293|079|028|0221|0258|0297|0260|0213|0263|0205|0214|0272|0228|0238|0259|0229|0257|0232|0235|0255|0203|0233|0299|0212|0276|0227|0208|0237|0234|0273|0294|0207|0270|0216|08|06|09)([0-9]{6,9})$',
  );

  ValidateFailResult? isTextEmpty(String? value) {
    if (value == null || value.isEmpty) {
      return ValidateFailResult.empty;
    }
    return null;
  }

  ValidateFailResult? isPasswordLength(String? value) {
    if (value == null || value.length < 6) {
      return ValidateFailResult.invalidAtLeastSixCharacter;
    }
    return null;
  }

  ValidateFailResult? isInvalidEmail(String? value) {
    if (value == null || !isEmailRegEx.hasMatch(value)) {
      return ValidateFailResult.invalidEmail;
    }
    return null;
  }

  ValidateFailResult? invalidPasswordType(bool? invalid) {
    if (invalid != null) {
      return ValidateFailResult.invalidPasswordType;
    }
    return null;
  }

  // at least 8 character (a-z)
  // at least 1 number (0-9)
  ValidateFailResult? isPasswordInvalid(String? value) {
    bool isInvalidLength = (value == null || value.length < 6);

    if (isInvalidLength) {
      return ValidateFailResult.invalidLength;
    }

    bool haveAtLeastOneNumber = hasNumberRegEx.hasMatch(value);

    if (!haveAtLeastOneNumber) {
      return ValidateFailResult.invalidPassword;
    }

    return null;
  }

  ValidateFailResult? isInvalidPhoneNumber(String? value) {
    String? isValidNumber = value?.replaceAll(isNumber, '');

    if (isValidNumber != null) {
      if (isValidNumber.length < 9) {
        return ValidateFailResult.invalidPhoneNumber;
      }
    }

    return null;
  }

  ValidateFailResult? isInvalidSequentialPin(String? value) {
    for (int i = 0; i < value!.length - 1; i++) {
      if (int.parse(value[i]) + 1 != int.parse(value[i + 1])) {
        return ValidateFailResult.invalidPhoneNumber;
      }
    }

    return null;
  }

  // check if pin follows a sequential pattern like 1111, 2222, 3333, etc.
  ValidateFailResult? isSequentialPin(String? pin) {
    for (int i = 0; i < pin!.length - 3; i++) {
      int digit1 = int.parse(pin[i]);
      int digit2 = int.parse(pin[i + 1]);
      int digit3 = int.parse(pin[i + 2]);
      int digit4 = int.parse(pin[i + 3]);

      if (digit1 == digit2 && digit2 == digit3 && digit3 == digit4) {
        return ValidateFailResult.invalidPhoneNumber;
      }
    }
    return null;
  }

  ValidateFailResult? isPasswordNotMatch(String? value, String? value2) {
    if (value != value2) {
      return ValidateFailResult.passwordNotMatch;
    }
    return null;
  }

  ValidateFailResult? isNewPasswordMatchOldPassword(
      String? newPassword, String? oldPassword) {
    if (newPassword == oldPassword) {
      return ValidateFailResult.isNewPasswordMatchOldPassword;
    }
    return null;
  }

  // isAccountNumberInvalid is not less than 10 characters and is greater than 11 characters
  ValidateFailResult? isAccountNumberInvalid(String? value) {
    if (value == null || value.length < 10 || value.length > 11) {
      return ValidateFailResult.isAccountNumberInvalid;
    }
    return null;
  }

  // check phone number to make sure the first digit is not 0
  ValidateFailResult? isPhoneNumberFirstDigitZero(String? value) {
    if (value == null || value[0] == '0') {
      return ValidateFailResult.invalidPhoneNumber;
    }
    return null;
  }

  // isPhoneNumberLessThanLength
  ValidateFailResult? isPhoneNumberLessThanLength(String? value) {
    if (value == null || value.length < 10) {
      return ValidateFailResult.invalidPhoneNumber;
    }
    return null;
  }

  ValidatorString combine(List<ValidatorString> validators) {
    return (String? str) {
      for (final validator in validators) {
        final result = validator(str);
        if (result != null) {
          return result;
        }
      }
      return null;
    };
  }

  ValidatorString withMessage(String message, Validator validator) {
    return (String? str) {
      final result = validator(str);
      if (result != null) {
        return message;
      }
      return null;
    };
  }

  String? isValidTermsAndConditions(bool? value, String message) {
    if (value == false || value == null) {
      return message;
    }
    return null;
  }
}
