part of 'new_password_bloc.dart';

class NewPasswordState extends Equatable {
  const NewPasswordState({
    this.status = FormzStatus.pure,
    this.currentPassword = const CurrentPassword.pure(),
    this.newPassword = const NewPassword.pure(),
    this.newPasswordConfirmation = const NewPasswordConfirmation.pure(),
  });

  final FormzStatus status;
  final CurrentPassword currentPassword;
  final NewPassword newPassword;
  final NewPasswordConfirmation newPasswordConfirmation;

  NewPasswordState copyWith({
    FormzStatus? status,
    CurrentPassword? currentPassword,
    NewPassword? newPassword,
    NewPasswordConfirmation? newPasswordConfirmation,
  }) {
    return NewPasswordState(
      status: status ?? this.status,
      currentPassword: currentPassword ?? this.currentPassword,
      newPassword: newPassword ?? this.newPassword,
      newPasswordConfirmation:
          newPasswordConfirmation ?? this.newPasswordConfirmation,
    );
  }

  @override
  List<Object?> get props =>
      [status, currentPassword, newPassword, newPasswordConfirmation];
}
