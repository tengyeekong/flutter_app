import 'package:flutter_app/data/models/ListItem.dart';
import 'package:flutter_app/data/models/Listing.dart';
import 'package:flutter_app/domain/repositories/listing_repository.dart';

class ListingUseCase {
  final ListingRepository listingRepository;

  ListingUseCase({required this.listingRepository});

  Future<Listing> getListing() async {
    return listingRepository.fetchListing();
  }

  Future<bool> updateListing(ListItem listItem) async {
    return listingRepository.updateListing(listItem: listItem);
  }
}
