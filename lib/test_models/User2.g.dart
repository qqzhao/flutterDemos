// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'User2.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User2<T> _$User2FromJson<T>(Map json) {
  return User2<T>(
    type: _$enumDecodeNullable(_$UserTypeEnumMap, json['type'],
        unknownValue: UserType.none),
    name: fromJson1(json['my_name'] as Map),
    age: json['age'] as num,
  )
    ..name2 =
        SimpleConverter<T>().fromJson(json['name2'] as Map<String, dynamic>)
    ..name3 = const SimpleConverter2()
        .fromJson(json['name3'] as Map<String, dynamic>);
}

Map<String, dynamic> _$User2ToJson<T>(User2<T> instance) => <String, dynamic>{
      'type': _$UserTypeEnumMap[instance.type],
      'my_name': instance.name,
      'name2': SimpleConverter<T>().toJson(instance.name2),
      'name3': const SimpleConverter2().toJson(instance.name3),
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
  UserType.none: 0,
  UserType.student: 1,
  UserType.teacher: 2,
};
