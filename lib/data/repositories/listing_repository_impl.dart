import 'package:flutter_app/data/datasources/remote/listing_remote_datasource.dart';
import 'package:flutter_app/data/models/list_item.dart';
import 'package:flutter_app/data/models/listing.dart';
import 'package:injectable/injectable.dart';

import '../../domain/repositories/listing_repository.dart';

@Injectable(as: ListingRepository, env: [Environment.dev, Environment.prod])
class ListingRepositoryImpl implements ListingRepository {
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
