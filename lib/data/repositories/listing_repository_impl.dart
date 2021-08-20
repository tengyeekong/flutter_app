import 'package:flutter_app/data/datasources/remote/listing_remote_datasource.dart';
import 'package:flutter_app/data/models/list_item.dart';
import 'package:flutter_app/data/models/listing.dart';

import '../../domain/repositories/listing_repository.dart';

class ListingRepositoryImpl extends ListingRepository {
  final ListingRemoteDataSource listingRemoteDataSource;

  ListingRepositoryImpl(this.listingRemoteDataSource);

  @override
  Future<Listing> fetchListing() async {
    return listingRemoteDataSource.getListing();
  }

  @override
  Future<bool> updateListing({required ListItem listItem}) async {
    return listingRemoteDataSource.updateList(listItem);
  }
}
