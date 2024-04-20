import 'package:flutter/widgets.dart' show FormFieldValidator;

mixin Validators {
  static FormFieldValidator<String> required(String errMsg) {
    return (value) {
      if (value == null) {
        return errMsg;
      } else if (value.isEmpty) {
        return errMsg;
      }
      return null;
    };
  }

  static FormFieldValidator<String> maxLength(int maxLength, String errMsg) {
    return (value) =>
        (value!.isNotEmpty && value.length > maxLength) ? errMsg : null;
  }

  static FormFieldValidator<String> compose(
    List<FormFieldValidator<String>> validatorList,
  ) {
    return (value) {
      for (final validator in validatorList) {
        if (validator(value) != null) return validator(value);
      }
      return null;
    };
  }
}
