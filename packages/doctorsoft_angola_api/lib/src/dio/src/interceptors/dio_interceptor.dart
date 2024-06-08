// ignore_for_file: avoid_void_async

import 'dart:io';

import 'package:dio/dio.dart';
import 'package:doctor_soft_angola_api/src/dio/src/interceptors/dio_request_retrier.dart';
import 'package:doctor_soft_angola_api/src/models/enviroment.dart';
import 'package:doctorsoft_storage/doctorsoft_storage.dart';

class DioClientInterceptor extends Interceptor {
  DioClientInterceptor({
    required this.requestRetrier,
    DoctorSecureStorage? storage,
  }) : _storage = storage ?? DoctorSecureStorage();

  final DioRequestRetrier requestRetrier;
  final DoctorSecureStorage _storage;

  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    String? token;
    if (options.path == '/refreshToken' || options.path == '/forgotPassword') {
      token = await _storage.getRefreshToken;
    } else {
      token = await _storage.getToken;
    }
    options.headers['Authorization'] = 'Bearer $token';

    super.onRequest(options, handler);
  }

  @override
  void onError(
    DioError err,
    ErrorInterceptorHandler handler,
  ) async {
    switch (err.type) {
      case DioErrorType.connectTimeout:
        handler.next(err);
        break;
      case DioErrorType.sendTimeout:
        handler.next(err);
        break;
      case DioErrorType.receiveTimeout:
        handler.next(err);
        break;
      case DioErrorType.response:
        if (err.response?.statusCode == 403) {
          try {
            await refreshToken();
            final response =
                await requestRetrier.retryRequest(err.requestOptions);
            handler.resolve(response);
          } catch (e) {
            handler.next(err);
          }
        }
        break;
      case DioErrorType.cancel:
        handler.next(err);
        break;
      case DioErrorType.other:
        if (_shouldRetry(err)) {
          final response =
              await requestRetrier.connectionRequestRetry(err.requestOptions);
          handler.resolve(response);
        }
        break;
    }
  }

  bool _shouldRetry(DioError err) {
    return err.type == DioErrorType.other &&
        err.error != null &&
        err.error is SocketException;
  }

  Future<void> refreshToken() async {
    final refreshToken = await _storage.getRefreshToken;

    if (refreshToken == null) throw Exception();

    final _dio = Dio(
      BaseOptions(
        baseUrl: urlApi,
        contentType: 'application/json',
        connectTimeout: 5000,
        receiveTimeout: 5000,
      ),
    );
    _dio.options.headers['Content-type'] = 'application/json';
    _dio.options.headers['Accept'] = 'application/json';
    _dio.options.headers['Authorization'] = 'Bearer $refreshToken';

    try {
      final user = await _dio.post(Endpoints.refreshToken);

      _storage.setTokens(
        token: user.data['data']['token'] as String,
        refreshToken: user.data['data']['refreshToken'] as String,
      );
    } on DioError catch (e) {
      print('[Dio Client - GET] Exception => ${e.message}');
      rethrow;
    } catch (_) {
      throw Exception();
    }
  }
}
