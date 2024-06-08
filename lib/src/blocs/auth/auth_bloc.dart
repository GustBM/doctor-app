import 'dart:async';

import 'package:authentication_repository/authentication_repository.dart';
import 'package:doctorsoft_storage/doctorsoft_storage.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medic_repository/medic_repository.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  AuthenticationBloc({
    required AuthenticationRepository authenticationRepository,
    required MedicRepository medicRepository,
    required DoctorSecureStorage doctorSecureStorage,
  })  : _authenticationRepository = authenticationRepository,
        _medicRepository = medicRepository,
        _doctorSecureStorage = doctorSecureStorage,
        super(const AuthenticationState.uninitialized()) {
    on<AuthenticationStatusChanged>(_onAuthenticationStatusChanged);
    on<AuthenticationLogoutRequested>(_onAuthenticationLogoutRequested);
    if (isClosed) return;
    _authenticationStatusSubscription = _authenticationRepository.status.listen(
      (status) => add(AuthenticationStatusChanged(status)),
    );
  }

  final AuthenticationRepository _authenticationRepository;
  final MedicRepository _medicRepository;
  final DoctorSecureStorage _doctorSecureStorage;
  late StreamSubscription<AuthenticationStatus>
      _authenticationStatusSubscription;

  @override
  Future<void> close() {
    _authenticationStatusSubscription.cancel();
    _authenticationRepository.dispose();
    _medicRepository.dispose();
    return super.close();
  }

  Future<void> _onAuthenticationStatusChanged(
    AuthenticationStatusChanged event,
    Emitter<AuthenticationState> emit,
  ) async {
    switch (event.status) {
      case AuthenticationStatus.unauthenticated:
        return emit(const AuthenticationState.unauthenticated());

      case AuthenticationStatus.authenticated:
        final user = await _tryGetUser();
        final medic = user != null ? await _tryGetMedic(user.uid) : null;
        if (user != null && medic != null) {
          _doctorSecureStorage.setTokens(
            token: user.token,
            refreshToken: user.refreshToken,
          );
        }
        return emit(
          user != null && medic != null
              ? AuthenticationState.authenticated(user, medic)
              : const AuthenticationState.unauthenticated(),
        );

      case AuthenticationStatus.unknown:
        return emit(const AuthenticationState.unknown());

      case AuthenticationStatus.appStart:
        final refreshToken = await _doctorSecureStorage.getRefreshToken;
        if (refreshToken == null) {
          return emit(const AuthenticationState.unauthenticated());
        }
        final user = await _tryTokenLogin(refreshToken);
        final medic = user != null ? await _tryGetMedic(user.uid) : null;

        if (user == null || medic == null) {
          return emit(const AuthenticationState.unauthenticated());
        } else {
          _doctorSecureStorage.setTokens(
            token: user.token,
            refreshToken: user.refreshToken,
          );
          return emit(AuthenticationState.authenticated(user, medic));
        }
    }
  }

  void _onAuthenticationLogoutRequested(
    AuthenticationLogoutRequested event,
    Emitter<AuthenticationState> emit,
  ) {
    _doctorSecureStorage.deleteTokens();
    _authenticationRepository.logOut();
  }

  Future<User?> _tryGetUser() async {
    try {
      final user = await _authenticationRepository.getUser();
      return user;
    } catch (_) {
      return null;
    }
  }

  Future<Medic?> _tryGetMedic(int medicId) async {
    try {
      final medic = await _medicRepository.getMedic(medicId);
      return medic;
    } catch (_) {
      return null;
    }
  }

  Future<User?> _tryTokenLogin(String refreshToken) async {
    try {
      return await _authenticationRepository.tokenLogin(refreshToken);
    } catch (_) {
      return null;
    }
  }
}
