// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'record_list.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RecordList _$RecordListFromJson(Map<String, dynamic> json) {
  return RecordList(
    records: (json['records'] as List<dynamic>)
        .map((e) => Record.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}

Map<String, dynamic> _$RecordListToJson(RecordList instance) =>
    <String, dynamic>{
      'records': instance.records,
    };
