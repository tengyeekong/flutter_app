import 'package:flutter_app/data/models/ListItem.dart';
import 'package:flutter_app/data/models/Listing.dart';

abstract class ListingRepository {
  Future<Listing> fetchListing();
  Future<bool> updateListing({required ListItem listItem});
}
