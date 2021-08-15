import 'package:flutter_app/models/ListItem.dart';
import 'package:flutter_app/models/Listing.dart';
import 'package:flutter_app/usecases/listing_usecase.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

part 'listing_event.dart';

part 'listing_state.dart';

class ListingBloc extends Bloc<ListingEvent, ListingState> {
  final ListingUseCase listingUseCase;

  ListingBloc({required this.listingUseCase}) : super(ListingState());

  @override
  Stream<ListingState> mapEventToState(ListingEvent event) async* {
    switch (event.runtimeType) {
      case FetchListingEvent:
        if ((event as FetchListingEvent).status != null) {
          state.status = event.status!;
        }
        yield* _fetchListing(event, state);
        break;
      default:
        break;
    }
  }

  Stream<ListingState> _fetchListing(
      FetchListingEvent event, ListingState state) async* {
    try {
      if (state.status == ListingStatus.initial) {
        final listing = await listingUseCase.getListing();
        yield ListingState(
          status: ListingStatus.success,
          data: listing,
          hasReachedEnd: false,
        );
      } else {
        await Future.delayed(Duration(seconds: 2));
        final listing = state.data;
        for (int i = 1; i <= 20; i++) {
          String value = (listing.lists.length + 1).toString();
          ListItem listItem = ListItem(id: value, name: value, distance: value);
          listing.lists.add(listItem);
        }
        yield ListingState(status: ListingStatus.success, data: listing);

        // final listing = await listingUseCase.getListing();
        // if (listing?.lists?.isNotEmpty ?? false) {
        //   yield ListingState(status: ListingStatus.success, data: listing);
        // } else {
        //   yield ListingState(
        //     status: ListingStatus.success,
        //     hasReachedEnd: true,
        //   );
        // }
      }
    } catch (_) {
      yield ListingState(status: ListingStatus.failure);
    }
  }
}
