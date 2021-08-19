import 'package:flutter_app/data/models/list_item.dart';
import 'package:flutter_app/data/models/listing.dart';
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
