import 'package:flutter_app/api/Api.dart';
import 'package:flutter_app/models/Listing.dart';

import 'listing_repository.dart';

class ListingRepositoryImpl extends ListingRepository {
  ListingRepositoryImpl();

  @override
  Future<Listing> fetchListing() async {
    return await Api.getListing();
  }
}
