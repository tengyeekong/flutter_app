import 'package:dio/dio.dart';
import 'package:flutter_app/models/ListItem.dart';
import 'package:flutter_app/models/Listing.dart';

class Api {
  static Dio dio = Dio();

  Api() {
    if (dio == null) dio = Dio();
    if (dio.options.baseUrl != "http://interview.advisoryapps.com/index.php") {
      dio.options.baseUrl = "http://interview.advisoryapps.com/index.php";
      dio.options.connectTimeout = 5000;
      dio.options.receiveTimeout = 3000;
    }
  }

  static getListing() async {
    Api();
    try {
      FormData loginData = FormData.fromMap(
          {"email": "movida@advisoryapps.com", "password": "movida123"});

      Response loginResponse = await dio.post(
        "/login",
        data: loginData,
      );
      if (loginResponse.statusCode == 200 &&
          loginResponse.data["status"]["code"] == 200) {
        Response listingResponse = await dio.get(
          "/listing",
          queryParameters: {
            "id": loginResponse.data["id"].toString(),
            "token": loginResponse.data["token"].toString()
          },
        );
        print(listingResponse);
        if (listingResponse.statusCode == 200 &&
            listingResponse.data["status"]["code"] == 200) {
          Listing lists = Listing.fromJson(listingResponse.data["listing"]);
          return lists;
        }
      }
    } catch (e) {
      print(e);
    }
  }

  static updateList(ListItem listItem) async {
    Api();
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
