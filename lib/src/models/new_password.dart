import 'package:formz/formz.dart';

enum CurrentPasswordValidationError { empty }

class CurrentPassword
    extends FormzInput<String, CurrentPasswordValidationError> {
  const CurrentPassword.pure() : super.pure('');
  const CurrentPassword.dirty([super.value = '']) : super.dirty();

  @override
  CurrentPasswordValidationError? validator(String? value) {
    return value?.isNotEmpty == true
        ? null
        : CurrentPasswordValidationError.empty;
  }
}

enum NewPasswordValidationError { empty }

class NewPassword extends FormzInput<String, NewPasswordValidationError> {
  const NewPassword.pure() : super.pure('');
  const NewPassword.dirty([super.value = '']) : super.dirty();

  @override
  NewPasswordValidationError? validator(String? value) {
    return value?.isNotEmpty == true ? null : NewPasswordValidationError.empty;
  }
}

enum NewPasswordConfirmationValidationError { empty, diferrentPwds }

class NewPasswordConfirmation
    extends FormzInput<String, NewPasswordConfirmationValidationError> {
  const NewPasswordConfirmation.pure() : super.pure('');
  const NewPasswordConfirmation.dirty(
      [super.value = '', String newPassword = ''])
      : super.dirty();

  @override
  NewPasswordConfirmationValidationError? validator(String? value) {
    return value?.isNotEmpty == true
        ? null
        : NewPasswordConfirmationValidationError.empty;
  }
}
