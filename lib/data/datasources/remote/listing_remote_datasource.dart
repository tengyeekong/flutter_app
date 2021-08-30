import 'package:dio/dio.dart';
import 'package:flutter_app/common/my_logger.dart';
import 'package:flutter_app/data/models/list_item.dart';
import 'package:flutter_app/data/models/listing.dart';
import 'package:injectable/injectable.dart';

import '../../../common/network/api_client.dart';

@injectable
class ListingRemoteDataSource {
  final ApiClient apiClient;

  ListingRemoteDataSource({required this.apiClient});

  Future<Listing> getListing() async {
    final Dio dio = ApiClient.dio;
    try {
      final FormData loginData = FormData.fromMap(
          {"email": "movida@advisoryapps.com", "password": "movida123"});

      final Response loginResponse = await dio.post(
        "/login",
        data: loginData,
      );
      if (loginResponse.statusCode == 200 &&
          loginResponse.data["status"]["code"] == 200) {
        final Response listingResponse = await dio.get(
          "/listing",
          queryParameters: {
            "id": loginResponse.data["id"].toString(),
            "token": loginResponse.data["token"].toString()
            // "id": "2",
            // "token": "95cecb7627ae09fe57b551f1d555e87e"
          },
        );
        MyLogger.d(listingResponse.toString());
        if (listingResponse.statusCode == 200 &&
            listingResponse.data["status"]["code"] == 200) {
          final Listing lists =
              Listing.fromJson(listingResponse.data as Map<String, dynamic>);
          return lists;
        }
      }
    } catch (e) {
      MyLogger.e(e.toString());
    }
    return const Listing();
  }

  Future<bool> updateList(ListItem listItem) async {
    final Dio dio = ApiClient.dio;
    try {
      final FormData loginData = FormData.fromMap(
          {"email": "movida@advisoryapps.com", "password": "movida123"});

      final Response loginResponse = await dio.post(
        "/login",
        data: loginData,
      );
      if (loginResponse.statusCode == 200 &&
          loginResponse.data["status"]["code"] == 200) {
        final FormData updateData = FormData.fromMap({
          "id": loginResponse.data["id"].toString(),
          "token": loginResponse.data["token"].toString(),
          "listing_id": listItem.id,
          "listing_name": listItem.name,
          "distance": listItem.distance
        });
        final Response updateResponse = await dio.post(
          "/listing/update",
          data: updateData,
        );
        MyLogger.d(updateResponse.toString());
        if (updateResponse.statusCode == 200 &&
            updateResponse.data["status"]["code"] == 200) {
          return true;
        } else {
          return false;
        }
      } else {
        return false;
      }
    } catch (e) {
      MyLogger.e(e.toString());
    }
    return false;
  }
}
