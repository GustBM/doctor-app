part of 'new_password_bloc.dart';

abstract class NewPasswordEvent extends Equatable {
  const NewPasswordEvent();

  @override
  List<Object> get props => [];
}

class NewPasswordCurrentPasswordChanged extends NewPasswordEvent {
  const NewPasswordCurrentPasswordChanged(this.currentPassword);

  final String currentPassword;

  @override
  List<Object> get props => [currentPassword];
}

class NewPasswordNewPasswordChanged extends NewPasswordEvent {
  const NewPasswordNewPasswordChanged(this.newPassword);

  final String newPassword;

  @override
  List<Object> get props => [newPassword];
}

class NewPasswordNewPasswordConfirmationChanged extends NewPasswordEvent {
  const NewPasswordNewPasswordConfirmationChanged(this.newPasswordConfirmation);

  final String newPasswordConfirmation;

  @override
  List<Object> get props => [newPasswordConfirmation];
}

class NewPasswordSubmitted extends NewPasswordEvent {
  const NewPasswordSubmitted();
}
