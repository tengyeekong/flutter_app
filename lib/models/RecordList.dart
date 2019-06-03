import 'Record.dart';

class RecordList {
  List<Record> records = List();

  RecordList({
    this.records
  });

  factory RecordList.fromJson(List<dynamic> parsedJson) {

    List<Record> records = List<Record>();

    records = parsedJson.map((i) => Record.fromJson(i)).toList();

    return RecordList(
      records: records,
    );
  }
}