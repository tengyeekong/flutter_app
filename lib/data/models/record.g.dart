// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'record.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Record _$RecordFromJson(Map<String, dynamic> json) {
  return Record(
    name: json['name'] as String,
    address: json['address'] as String,
    contact: json['contact'] as String,
    photo: json['photo'] as String,
    url: json['url'] as String,
  );
}

Map<String, dynamic> _$RecordToJson(Record instance) => <String, dynamic>{
      'name': instance.name,
      'address': instance.address,
      'contact': instance.contact,
      'photo': instance.photo,
      'url': instance.url,
    };
