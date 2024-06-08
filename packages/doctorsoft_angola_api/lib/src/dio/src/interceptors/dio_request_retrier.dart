// ignore_for_file: strict_raw_type

import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';

class DioRequestRetrier {
  DioRequestRetrier({
    required this.dio,
    required this.connectivity,
  });

  final Dio dio;
  final Connectivity connectivity;

  Future<Response> connectionRequestRetry(RequestOptions requestOptions) async {
    late StreamSubscription<ConnectivityResult> streamSubscription;
    final responseCompleter = Completer<Response>();

    streamSubscription = connectivity.onConnectivityChanged.listen(
      (connectivityResult) async {
        if (connectivityResult != ConnectivityResult.none) {
          await streamSubscription.cancel();

          responseCompleter.complete(
            dio.request(
              requestOptions.path,
              cancelToken: requestOptions.cancelToken,
              data: requestOptions.data,
              onReceiveProgress: requestOptions.onReceiveProgress,
              onSendProgress: requestOptions.onSendProgress,
              queryParameters: requestOptions.queryParameters,
              options: Options(
                method: requestOptions.method,
                headers: requestOptions.headers,
              ),
            ),
          );
        }
      },
    );

    return responseCompleter.future;
  }

  Future<Response> retryRequest(RequestOptions requestOptions) async {
    final responseCompleter = Completer<Response>();
    // ignore: cascade_invocations
    responseCompleter.complete(
      dio.request(
        requestOptions.path,
        data: requestOptions.data,
        queryParameters: requestOptions.queryParameters,
        options: Options(
          method: requestOptions.method,
          headers: requestOptions.headers,
        ),
      ),
    );
    return responseCompleter.future;
  }
}
