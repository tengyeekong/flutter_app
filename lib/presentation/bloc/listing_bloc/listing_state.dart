part of 'listing_bloc.dart';

enum ListingStatus { initial, success, failure }

abstract class ListingState {
  ListingState({
    this.status = ListingStatus.initial,
  });

  ListingStatus status;
}

class FetchListingState extends ListingState {
  FetchListingState({
    this.status = ListingStatus.initial,
    this.data = const Listing(),
    this.hasReachedEnd = false,
  }) : super(status: status);

  ListingStatus status;
  Listing data;
  bool hasReachedEnd;
}

class UpdateListingState extends ListingState {
  UpdateListingState({
    this.status = ListingStatus.initial,
    this.data,
  }) : super(status: status);

  ListingStatus status;
  ListItem? data;
}
