// ignore_for_file: strict_raw_type, inference_failure_on_function_invocation, avoid_print
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:doctor_soft_angola_api/src/dio/src/interceptors/dio_interceptor.dart';
import 'package:doctor_soft_angola_api/src/dio/src/interceptors/dio_request_retrier.dart';
import 'package:doctor_soft_angola_api/src/models/models.dart' show urlApi;

class DioClient {
  DioClient() {
    _dio.interceptors.add(
      DioClientInterceptor(
        requestRetrier: DioRequestRetrier(
          dio: _dio,
          connectivity: Connectivity(),
        ),
      ),
    );
  }

  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: urlApi,
      contentType: 'application/json',
      connectTimeout: 10000,
      receiveTimeout: 10000,
    ),
  );

  Future<Response> get({
    required String endpoint,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      final response = await _dio.get(
        endpoint,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onReceiveProgress: onReceiveProgress,
      );

      if (response.statusCode != 200) {
        throw Exception(response.statusMessage);
      }

      return response;
    } on DioError catch (e) {
      print('[Dio Client - GET] Exception => ${e.message}');
      rethrow;
    }
  }

  Future<Response> post({
    required String endpoint,
    String? data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      final response = await _dio.post(
        endpoint,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );

      if (response.statusCode != 200) {
        throw Exception(response.statusMessage);
      }

      return response;
    } on DioError catch (e) {
      print('[Dio Client - POST] Exception => ${e.message}');
      rethrow;
    }
  }

  Future<Response> put({
    required String endpoint,
    String? data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      final response = await _dio.put(
        endpoint,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );

      if (response.statusCode != 200) {
        throw Exception(response.statusMessage);
      }

      return response;
    } on DioError catch (e) {
      print('[Dio Client - PUT] Exception => ${e.message}');
      rethrow;
    }
  }

  Future<dynamic> delete({
    required String endpoint,
    String? data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      final response = await _dio.delete(
        endpoint,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
      );

      if (response.statusCode != 200) {
        throw Exception(response.statusMessage);
      }

      return response.data;
    } on DioError catch (e) {
      print('[Dio Client - DELETE] Exception => ${e.message}');
      rethrow;
    }
  }
}
