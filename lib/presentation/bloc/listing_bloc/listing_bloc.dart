import 'package:flutter_app/data/models/list_item.dart';
import 'package:flutter_app/data/models/listing.dart';
import 'package:flutter_app/domain/usecases/listing_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'listing_event.dart';
part 'listing_state.dart';

class ListingBloc extends Bloc<ListingEvent, ListingState> {
  final ListingUseCase listingUseCase;

  ListingBloc({required this.listingUseCase}) : super(FetchListingState());

  @override
  Stream<ListingState> mapEventToState(ListingEvent event) async* {
    if (event is FetchListingEvent) {
      yield* _fetchListing(event);
    } else if (event is UpdateListingEvent) {
      yield* _updateListing(event);
    }
  }

  Stream<ListingState> _fetchListing(FetchListingEvent event) async* {
    try {
      if (event.status == ListingStatus.initial || event.listItems.isEmpty) {
        final listing = await listingUseCase.getListing();
        yield FetchListingState(
          status: ListingStatus.success,
          data: listing,
          hasReachedEnd: false,
        );
      } else {
        await Future.delayed(Duration(seconds: 2));
        final listItems = event.listItems;
        for (int i = 1; i <= 20; i++) {
          String value = (listItems.length + 1).toString();
          ListItem listItem = ListItem(id: value, name: value, distance: value);
          listItems.add(listItem);
        }
        yield FetchListingState(
            status: ListingStatus.success, data: Listing(lists: listItems));
      }
    } catch (_) {
      yield FetchListingState(status: ListingStatus.failure);
    }
  }

  Stream<ListingState> _updateListing(UpdateListingEvent event) async* {
    try {
      final updateSuccess = await listingUseCase.updateListing(event.listItem);
      if (updateSuccess) {
        yield UpdateListingState(
            status: ListingStatus.success, data: event.listItem);
      } else {
        yield UpdateListingState(status: ListingStatus.failure);
      }
    } catch (_) {
      yield UpdateListingState(status: ListingStatus.failure);
    }
  }
}
