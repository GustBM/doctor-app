part of 'login_bloc.dart';

class LoginState extends Equatable {
  const LoginState({
    this.status = FormzStatus.pure,
    this.userEmail = const UserEmail.pure(),
    this.password = const Password.pure(),
  });

  final FormzStatus status;
  final UserEmail userEmail;
  final Password password;

  LoginState copyWith({
    FormzStatus? status,
    UserEmail? userEmail,
    Password? password,
  }) {
    return LoginState(
      status: status ?? this.status,
      userEmail: userEmail ?? this.userEmail,
      password: password ?? this.password,
    );
  }

  @override
  List<Object> get props => [status, userEmail, password];
}
