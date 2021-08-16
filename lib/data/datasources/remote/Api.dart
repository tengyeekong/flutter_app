import 'package:dio/dio.dart';
import 'package:flutter_app/data/models/ListItem.dart';
import 'package:flutter_app/data/models/Listing.dart';

class ApiClient {
  static Dio dio = Dio();

  ApiClient() {
    setupDio();
  }

  setupDio() {
    if (dio.options.baseUrl != "http://interview.advisoryapps.com/index.php") {
      dio.options.baseUrl = "http://interview.advisoryapps.com/index.php";
      dio.options.connectTimeout = 5000;
      dio.options.receiveTimeout = 3000;
    }
  }

  updateList(ListItem listItem) async {
    try {
      FormData loginData = FormData.fromMap(
          {"email": "movida@advisoryapps.com", "password": "movida123"});

      Response loginResponse = await dio.post(
        "/login",
        data: loginData,
      );
      if (loginResponse.statusCode == 200 &&
          loginResponse.data["status"]["code"] == 200) {
        FormData updateData = FormData.fromMap({
          "id": loginResponse.data["id"].toString(),
          "token": loginResponse.data["token"].toString(),
          "listing_id": listItem.id,
          "listing_name": listItem.name,
          "distance": listItem.distance
        });
        Response updateResponse = await dio.post(
          "/listing/update",
          data: updateData,
        );
        print(updateResponse);
        if (updateResponse.statusCode == 200 &&
            updateResponse.data["status"]["code"] == 200) {
          return true;
        } else
          return false;
      } else
        return false;
    } catch (e) {
      print(e);
    }
  }
}
