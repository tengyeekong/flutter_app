import 'package:flutter_app/data/models/list_item.dart';
import 'package:flutter_app/data/models/listing.dart';

abstract class ListingRepository {
  Future<Listing> fetchListing();
  Future<bool> updateListing({required ListItem listItem});
}
