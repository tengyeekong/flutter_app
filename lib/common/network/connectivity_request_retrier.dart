import 'dart:async';

import 'package:connectivity/connectivity.dart';
import 'package:dio/dio.dart';

import 'multipart_file_extended.dart';

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
          FormData formData = FormData();
          if (requestOptions.data is FormData) {
            formData.fields.addAll(requestOptions.data.fields);
            for (MapEntry mapFile in requestOptions.data.files) {
              formData.files.add(MapEntry(
                  mapFile.key,
                  MultipartFileExtended.fromFileSync(mapFile.value.filePath,
                      filename: mapFile.value.filename)));
            }
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
