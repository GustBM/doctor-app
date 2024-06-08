import 'dart:async';
import 'dart:convert';

import 'package:authentication_repository/authentication_repository.dart';
import 'package:doctor_soft_angola_api/src/dio/dio_client.dart';

import 'package:doctor_soft_angola_api/src/models/models.dart';

class AuthRequestFailure implements Exception {
  const AuthRequestFailure([
    this.message = 'Houve um erro desconhecido.',
  ]);

  factory AuthRequestFailure.fromCode(int? statusCode) {
    switch (statusCode) {
      case 404:
        return const AuthRequestFailure(
          'Erro de Envio. Verifique a conexão e tente novamente.',
        );
      case 406:
        return const AuthRequestFailure(
          'Usuário não encontrado. Verifique as informações e tente novamente.',
        );
      default:
        return const AuthRequestFailure();
    }
  }

  final String message;
}

class AuthApiClient {
  AuthApiClient({
    DioClient? dioClient,
  }) : _dioClient = dioClient ?? DioClient();

  final DioClient _dioClient;

  Future<User> getUser({
    required String email,
    required String password,
  }) async {
    final userResponse = await _dioClient.post(
      endpoint: Endpoints.login,
      data: jsonEncode(<String, String>{
        'email': email,
        'senha': password,
        'apk_type': apkType,
      }),
    );

    if (userResponse.statusCode != 200) {
      throw AuthRequestFailure.fromCode(userResponse.statusCode);
    }

    final res =
        User.fromJson(userResponse.data['data'] as Map<String, dynamic>);

    return res;
  }

  Future<User> getUserWithRefreshToken(String refreshToken) async {
    final userResponse = await _dioClient.post(
      endpoint: Endpoints.refreshToken,
    );

    if (userResponse.statusCode != 200) {
      throw AuthRequestFailure.fromCode(userResponse.statusCode);
    }

    final res =
        User.fromJson(userResponse.data['data'] as Map<String, dynamic>);

    return res;
  }

  Future<void> requestForgotPassword(String email) async {
    final requestResponse = await _dioClient.post(
      endpoint: Endpoints.forgotPassword,
      data: jsonEncode(<String, String>{
        'email': email,
      }),
    );

    if (requestResponse.statusCode != 200) {
      throw AuthRequestFailure.fromCode(requestResponse.statusCode);
    }
  }

  Future<void> requestNewPassword({
    required String currentPwd,
    required String newPwd,
    required String newPwdConfirmation,
  }) async {
    final requestResponse = await _dioClient.post(
      endpoint: Endpoints.newPassword,
      data: jsonEncode(<String, String>{
        'senha': currentPwd,
        'novaSenha': newPwd,
        'confirmarNovaSenha': newPwdConfirmation,
      }),
    );

    if (requestResponse.statusCode != 200) {
      throw AuthRequestFailure.fromCode(requestResponse.statusCode);
    }
  }
}
