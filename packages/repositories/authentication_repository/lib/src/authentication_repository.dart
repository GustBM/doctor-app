import 'dart:async';

import 'package:authentication_repository/src/models/user.dart';
import 'package:doctor_soft_angola_api/doctorsoft_angola_api.dart';

enum AuthenticationStatus { unknown, authenticated, unauthenticated, appStart }

class AuthenticationRepository {
  AuthenticationRepository({AuthApiClient? authApiClient})
      : _authApiClient = authApiClient ?? AuthApiClient();

  final AuthApiClient _authApiClient;
  final _controller = StreamController<AuthenticationStatus>();

  Stream<AuthenticationStatus> get status async* {
    yield AuthenticationStatus.appStart;
    yield* _controller.stream;
  }

  User? _user;

  Future<User?> getUser() async => _user;

  String? get getUserToken => _user == null ? null : _user!.token;
  String? get getUserRefreshToken => _user == null ? null : _user!.refreshToken;

  Future<void> logIn({
    required String email,
    required String password,
  }) async {
    try {
      _user = await _authApiClient.getUser(
        email: email,
        password: password,
      );
      _controller.add(AuthenticationStatus.authenticated);
    } catch (_) {
      _controller.add(AuthenticationStatus.unauthenticated);
      throw Exception();
    }
  }

  Future<User?> tokenLogin(String refreshToken) async {
    try {
      // ignore: join_return_with_assignment
      _user = await _authApiClient.getUserWithRefreshToken(refreshToken);
      return _user;
    } catch (e) {
      throw Exception();
    }
  }

  Future<void> forgotPassword(String email) async {
    try {
      await _authApiClient.requestForgotPassword(email);
    } catch (_) {
      throw Exception();
    }
  }

  Future<void> newPassword({
    required String currentPassword,
    required String newPassword,
    required String newPasswordConfirmation,
  }) async {
    try {
      await _authApiClient.requestNewPassword(
        currentPwd: currentPassword,
        newPwd: newPassword,
        newPwdConfirmation: newPasswordConfirmation,
      );
    } catch (_) {
      throw Exception();
    }
  }

  void logOut() {
    _controller.add(AuthenticationStatus.unauthenticated);
  }

  void dispose() => _controller.close();
}
