part of 'listing_bloc.dart';

enum ListingStatus { initial, success, failure }

abstract class ListingState {
  ListingState({
    this.status = ListingStatus.initial,
  });

  ListingStatus status;
}

class FetchListingState implements ListingState {
  FetchListingState({
    this.status = ListingStatus.initial,
    this.data = const Listing(),
    this.hasReachedEnd = false,
  });

  @override
  ListingStatus status;
  Listing data;
  bool hasReachedEnd;
}

class UpdateListingState implements ListingState {
  UpdateListingState({
    this.status = ListingStatus.initial,
    this.data,
  });

  @override
  ListingStatus status;
  ListItem? data;
}
