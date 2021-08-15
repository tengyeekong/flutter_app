import 'package:flutter_app/models/Listing.dart';

import '../listing_repository.dart';

class ListingUseCase {
  final ListingRepository listingRepository;

  ListingUseCase({required this.listingRepository});

  Future<Listing> getListing() async {
    return listingRepository.fetchListing();
  }
}
