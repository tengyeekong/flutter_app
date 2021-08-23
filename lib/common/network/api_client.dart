import 'package:connectivity/connectivity.dart';
import 'package:dio/dio.dart';
import 'package:flutter_app/common/network/retry_interceptor.dart';
import 'package:injectable/injectable.dart';

import 'connectivity_request_retrier.dart';

@singleton
class ApiClient {
  static Dio dio = Dio();

  ApiClient() {
    setupDio();
  }

  void setupDio() {
    dio.options.baseUrl = "http://interview.advisoryapps.com/index.php";
    // dio.options.connectTimeout = 5000;
    // dio.options.receiveTimeout = 3000;
    dio.interceptors.add(
      RetryOnConnectionChangeInterceptor(
        requestRetrier: DioConnectivityRequestRetrier(
          dio: dio,
          connectivity: Connectivity(),
        ),
      ),
    );
  }
}
