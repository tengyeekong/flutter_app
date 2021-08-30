import 'package:json_annotation/json_annotation.dart';

import 'list_item.dart';

part 'listing.g.dart';

@JsonSerializable()
class Listing {
  @JsonKey(name: "listing")
  final List<ListItem> lists;

  const Listing({this.lists = const []});

  factory Listing.fromJson(Map<String, dynamic> json) =>
      _$ListingFromJson(json);
}
