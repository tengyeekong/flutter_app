import 'package:json_annotation/json_annotation.dart';

part 'record.g.dart';

@JsonSerializable()
class Record {
  String name;
  String address;
  String contact;
  String photo;
  String url;

  Record(
      {required this.name,
      required this.address,
      required this.contact,
    required this.photo,
    required this.url});

  factory Record.fromJson(Map<String, dynamic> json) => _$RecordFromJson(json);
}
