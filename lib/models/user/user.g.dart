// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

/// ignore_for_file: avoid_as
// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) {
  return User()
    ..id = json['id'] as int
    ..schoolName = json['schoolName'] as String
    ..name = json['name'] as String
    ..age = json['age'] as int;
}

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'id': instance.id,
      'schoolName': instance.schoolName,
      'name': instance.name,
      'age': instance.age,
    };
