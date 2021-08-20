import 'dart:io';

import 'package:dio/dio.dart';

import '../my_logger.dart';
import 'connectivity_request_retrier.dart';

class RetryOnConnectionChangeInterceptor extends Interceptor {
  final DioConnectivityRequestRetrier requestRetrier;

  RetryOnConnectionChangeInterceptor({
    required this.requestRetrier,
  });

  @override
  Future onError(DioError err, ErrorInterceptorHandler handler) async {
    if (_shouldRetry(err)) {
      try {
        if (err.requestOptions.data is FormData &&
            (err.requestOptions.data as FormData).files.isEmpty) {
          final Response response =
              await requestRetrier.scheduleRequestRetry(err.requestOptions);
          MyLogger.d(response.toString());
          handler.resolve(response);
          return;
        }
      } catch (e) {
        // Let any new error from the retrier pass through
        handler.next(err);
        return;
      }
    }
    // Let the error pass through if it's not the error we're looking for
    handler.next(err);
  }

  bool _shouldRetry(DioError err) {
    return err.type == DioErrorType.other &&
        err.error != null &&
        err.error is SocketException;
  }
}
