import 'ListItem.dart';

class Listing {
  final List<ListItem> lists;

  const Listing({this.lists = const []});

  factory Listing.fromJson(List<dynamic> parsedJson) {
    List<ListItem> lists = <ListItem>[];

    lists = parsedJson.map((i) => ListItem.fromJson(i)).toList();

    return Listing(
      lists: lists,
    );
  }
}
