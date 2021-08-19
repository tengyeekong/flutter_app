import 'dart:io';

import 'package:dio/dio.dart';

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
        // return requestRetrier.scheduleRequestRetry(err.requestOptions);
        Response response =
            await requestRetrier.scheduleRequestRetry(err.requestOptions);
        print(response.toString());
        handler.resolve(response);
      } catch (e) {
        // Let any new error from the retrier pass through
        handler.next(err);
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
