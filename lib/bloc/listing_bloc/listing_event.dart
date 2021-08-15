part of 'listing_bloc.dart';

abstract class ListingEvent {
  ListingEvent();
}

class FetchListingEvent extends ListingEvent {
  ListingStatus? status;

  FetchListingEvent({this.status}) : super();
}
