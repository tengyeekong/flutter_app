import 'dart:convert';

import 'package:flutter/services.dart' show rootBundle;

import 'record_list.dart';

class RecordService {
  Future<String> _loadRecordsAsset() async {
    return rootBundle.loadString('assets/data/records.json');
  }

  Future<RecordList> loadRecords() async {
    final String jsonString = await _loadRecordsAsset();
    final jsonResponse = json.decode(jsonString);
    final RecordList records =
        RecordList.fromJson(jsonResponse as List<dynamic>);
    return records;
  }
}
