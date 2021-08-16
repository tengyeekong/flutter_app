import 'package:dio/dio.dart';
import 'package:flutter_app/data/models/ListItem.dart';
import 'package:flutter_app/data/models/Listing.dart';

import 'Api.dart';

class ListingRemoteDataSource {
  final ApiClient apiClient;

  ListingRemoteDataSource({required this.apiClient});

  Future<Listing> getListing() async {
    Dio dio = ApiClient.dio;
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
    return Listing();
  }

  Future<bool> updateList(ListItem listItem) async {
    Dio dio = ApiClient.dio;
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
    return false;
  }
}
