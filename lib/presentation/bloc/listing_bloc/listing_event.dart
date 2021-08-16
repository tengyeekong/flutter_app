part of 'listing_bloc.dart';

abstract class ListingEvent {
  ListingEvent();
}

class FetchListingEvent extends ListingEvent {
  ListingStatus? status;
  List<ListItem> listItems;

  FetchListingEvent({this.status, required this.listItems}) : super();
}

class UpdateListingEvent extends ListingEvent {
  ListItem listItem;

  UpdateListingEvent({required this.listItem}) : super();
}
