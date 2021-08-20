import 'dart:async';

import 'package:connectivity/connectivity.dart';
import 'package:dio/dio.dart';

class DioConnectivityRequestRetrier {
  final Dio dio;
  final Connectivity connectivity;

  DioConnectivityRequestRetrier({
    required this.dio,
    required this.connectivity,
  });

  Future<Response> scheduleRequestRetry(RequestOptions requestOptions) async {
    StreamSubscription? streamSubscription;
    final responseCompleter = Completer<Response>();

    streamSubscription = connectivity.onConnectivityChanged.listen(
      (connectivityResult) async {
        if (connectivityResult != ConnectivityResult.none) {
          final FormData formData = FormData();
          if (requestOptions.data is FormData) {
            final FormData reqOptFormData = requestOptions.data as FormData;
            formData.fields.addAll(reqOptFormData.fields);
            requestOptions.data = formData;
          }

          // Complete the completer instead of returning
          responseCompleter.complete(dio.fetch(requestOptions));
          streamSubscription?.cancel();
        }
      },
    );
    return responseCompleter.future;
  }
}
