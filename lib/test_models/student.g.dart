// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'student.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Student _$StudentFromJson(Map json) {
  return Student(
    classmates: (json['classmates'] as List)
        ?.map((e) => e == null
            ? null
            : User2.fromJson((e as Map)?.map(
                (k, e) => MapEntry(k as String, e),
              )))
        ?.toList(),
    grade: json['grade'] as num,
  )
    ..type = _$enumDecodeNullable(_$UserTypeEnumMap, json['type'],
        unknownValue: UserType.none)
    ..name = fromJson1(json['my_name'] as Map)
    ..name2 = json['name2']
    ..name3 =
        const SimpleConverter2().fromJson(json['name3'] as Map<String, dynamic>)
    ..age = json['age'] as num;
}

Map<String, dynamic> _$StudentToJson(Student instance) => <String, dynamic>{
      'type': _$UserTypeEnumMap[instance.type],
      'my_name': instance.name,
      'name2': instance.name2,
      'name3': const SimpleConverter2().toJson(instance.name3),
      'age': instance.age,
      'classmates': instance.classmates?.map((e) => e?.toJson())?.toList(),
      'grade': instance.grade,
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
