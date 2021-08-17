import 'Record.dart';

class RecordList {
  List<Record> records;

  RecordList({required this.records});

  factory RecordList.fromJson(List<dynamic> parsedJson) {
    List<Record> records = [];

    records = parsedJson.map((i) => Record.fromJson(i)).toList();

    return RecordList(
      records: records,
    );
  }
}
