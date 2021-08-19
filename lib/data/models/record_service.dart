import 'dart:convert';

import 'package:flutter/services.dart' show rootBundle;

import 'record_list.dart';

class RecordService {
  Future<String> _loadRecordsAsset() async {
    return await rootBundle.loadString('assets/data/records.json');
  }

  Future<RecordList> loadRecords() async {
    String jsonString = await _loadRecordsAsset();
    final jsonResponse = json.decode(jsonString);
    RecordList records = RecordList.fromJson(jsonResponse);
    return records;
  }
}
