import 'package:json_annotation/json_annotation.dart';

import 'record.dart';

part 'record_list.g.dart';

@JsonSerializable()
class RecordList {
  List<Record> records;

  RecordList({required this.records});

  factory RecordList.fromJson(Map<String, dynamic> json) =>
      _$RecordListFromJson(json);
}
