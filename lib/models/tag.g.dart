// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tag.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Tag _$TagFromJson(Map<String, dynamic> json) {
  return Tag()
    ..id = json['id'] as int
    ..tagName = json['tagName'] as String
    ..age = json['age'] as int
    ..tagNum = json['tagNum'] as int;
}

Map<String, dynamic> _$TagToJson(Tag instance) => <String, dynamic>{
      'id': instance.id,
      'tagName': instance.tagName,
      'age': instance.age,
      'tagNum': instance.tagNum,
    };
