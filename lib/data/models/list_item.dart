import 'package:json_annotation/json_annotation.dart';

part 'list_item.g.dart';

@JsonSerializable()
class ListItem {
  String id;
  @JsonKey(name: "list_name")
  String name;
  String distance;

  ListItem({required this.id, this.name = "", this.distance = ""});

  factory ListItem.fromJson(Map<String, dynamic> json) =>
      _$ListItemFromJson(json);
}
