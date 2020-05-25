// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'User2.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User2 _$User2FromJson(Map json) {
  return User2()
    ..type = _$enumDecodeNullable(_$UserTypeEnumMap, json['type'])
    ..name = json['name'] as String
    ..age = json['age'] as num;
}

Map<String, dynamic> _$User2ToJson(User2 instance) => <String, dynamic>{
      'type': _$UserTypeEnumMap[instance.type],
      'name': instance.name,
      'age': instance.age,
    };

T _$enumDecode<T>(
  Map<T, dynamic> enumValues,
  dynamic source, {
  T unknownValue,
}) {
  if (source == null) {
    throw ArgumentError('A value must be provided. Supported values: '
        '${enumValues.values.join(', ')}');
  }

  final value = enumValues.entries
      .singleWhere((e) => e.value == source, orElse: () => null)
      ?.key;

  if (value == null && unknownValue == null) {
    throw ArgumentError('`$source` is not one of the supported values: '
        '${enumValues.values.join(', ')}');
  }
  return value ?? unknownValue;
}

T _$enumDecodeNullable<T>(
  Map<T, dynamic> enumValues,
  dynamic source, {
  T unknownValue,
}) {
  if (source == null) {
    return null;
  }
  return _$enumDecode<T>(enumValues, source, unknownValue: unknownValue);
}

const _$UserTypeEnumMap = {
  UserType.none: 'none',
  UserType.student: 'student',
  UserType.teacher: 'teacher',
  UserType.parents: 'parents',
};
