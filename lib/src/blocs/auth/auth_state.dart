part of 'auth_bloc.dart';

class AuthenticationState extends Equatable {
  const AuthenticationState._({
    this.status = AuthenticationStatus.unknown,
    this.user = User.empty,
    this.medic = Medic.empty,
  });

  const AuthenticationState.unknown() : this._();

  const AuthenticationState.authenticated(User user, Medic medic)
      : this._(
          status: AuthenticationStatus.authenticated,
          user: user,
          medic: medic,
        );

  const AuthenticationState.unauthenticated()
      : this._(status: AuthenticationStatus.unauthenticated);

  const AuthenticationState.uninitialized()
      : this._(status: AuthenticationStatus.appStart);

  final AuthenticationStatus status;
  final User user;
  final Medic medic;

  @override
  List<Object> get props => [status, user];
}
