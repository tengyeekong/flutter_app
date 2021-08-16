import 'package:flutter_app/data/datasources/remote/Api.dart';
import 'package:flutter_app/data/datasources/remote/listing_remote_datasource.dart';
import 'package:flutter_app/data/models/ListItem.dart';
import 'package:flutter_app/data/models/Listing.dart';

import '../../domain/repositories/listing_repository.dart';

class ListingRepositoryImpl extends ListingRepository {
  final ListingRemoteDataSource listingRemoteDataSource;

  ListingRepositoryImpl(this.listingRemoteDataSource);

  @override
  Future<Listing> fetchListing() async {
    return await listingRemoteDataSource.getListing();
  }

  @override
  Future<bool> updateListing({required ListItem listItem}) async {
    return await listingRemoteDataSource.updateList(listItem);
  }
}
