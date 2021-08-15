part of 'listing_bloc.dart';

enum ListingStatus { initial, success, failure }

class ListingState {
  ListingState({
    this.status = ListingStatus.initial,
    this.data = const Listing(),
    this.hasReachedEnd = false,
  });

  ListingStatus status;
  Listing data;
  bool hasReachedEnd;

  // ListingState copyWith({
  //   ListingStatus? status,
  //   Listing? data,
  //   bool? hasReachedEnd,
  // }) {
  //   return ListingState(
  //     status: status ?? this.status,
  //     data: data ?? this.data,
  //     hasReachedEnd: hasReachedEnd ?? this.hasReachedEnd,
  //   );
  // }
}
