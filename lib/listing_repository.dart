import 'models/Listing.dart';

abstract class ListingRepository {
  Future<Listing> fetchListing();
}
