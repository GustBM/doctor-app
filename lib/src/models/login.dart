import 'package:formz/formz.dart';

import '../../utils.dart';

enum UserEmailValidationError { empty, dirty }

class UserEmail extends FormzInput<String, UserEmailValidationError> {
  const UserEmail.pure() : super.pure('');
  const UserEmail.dirty([super.value = '']) : super.dirty();

  @override
  UserEmailValidationError? validator(String? value) {
    if (value == null || value.isEmpty) {
      return UserEmailValidationError.empty;
    } else if (!isValidEmail(value)) {
      return UserEmailValidationError.dirty;
    } else {
      return null;
    }
    // return value?.isNotEmpty == true ? null : UserEmailValidationError.empty;
  }
}

enum PasswordValidationError { empty }

class Password extends FormzInput<String, PasswordValidationError> {
  const Password.pure() : super.pure('');
  const Password.dirty([super.value = '']) : super.dirty();

  @override
  PasswordValidationError? validator(String? value) {
    return value?.isNotEmpty == true ? null : PasswordValidationError.empty;
  }
}
