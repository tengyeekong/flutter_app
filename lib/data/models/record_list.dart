import 'record.dart';

class RecordList {
  List<Record> records;

  RecordList({required this.records});

  factory RecordList.fromJson(List<dynamic> parsedJson) {
    List<Record> records = [];

    records = parsedJson
        .map((i) => Record.fromJson(i as Map<String, dynamic>))
        .toList();

    return RecordList(
      records: records,
    );
  }
}
