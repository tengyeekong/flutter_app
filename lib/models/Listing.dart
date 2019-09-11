import 'ListItem.dart';

class Listing {
  List<ListItem> lists = List();

  Listing({
    this.lists
  });

  factory Listing.fromJson(List<dynamic> parsedJson) {

    List<ListItem> lists = List<ListItem>();

    lists = parsedJson.map((i) => ListItem.fromJson(i)).toList();

    return Listing(
      lists: lists,
    );
  }
}