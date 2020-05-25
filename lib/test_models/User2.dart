import 'package:json_annotation/json_annotation.dart';

import 'enum.dart';

part 'User2.g.dart';

dynamic fromJson1(Map obj) {
  return obj['aaa'] ?? obj['bbb'];
}

class _SimpleConverter<T> implements JsonConverter<T, Map<String, dynamic>> {
  const _SimpleConverter();

  @override
  T fromJson(Map<String, dynamic> json) => json['value'] as T;

  @override
  Map<String, dynamic> toJson(T object) => {'value': object};
}

class _SimpleConverter2 implements JsonConverter<String, Map<String, dynamic>> {
  const _SimpleConverter2();

  @override
  String fromJson(Map<String, dynamic> json) => json['value'] as String;

  @override
  Map<String, dynamic> toJson(String object) => {'value': object};
}

@JsonSerializable(explicitToJson: true, anyMap: true)
class User2<T> {
  @JsonKey(unknownEnumValue: UserType.none)
  UserType type;
  @JsonKey(
    ignore: false,
    name: 'my_name',
    fromJson: fromJson1,
  )
  String name;

  @_SimpleConverter()
  @JsonKey(name: null)
  T name2;

  @_SimpleConverter2()
  String name3;
  num age;

  User2({this.type, this.name, this.age});
  factory User2.fromJson(Map<String, dynamic> json) => _$User2FromJson(json);
  Map<String, dynamic> toJson() => _$User2ToJson(this);
}

//class User3 {
//  UserType type;
//  String name;
//  num age;
//
//  User3({this.type, this.name, this.age});
//  factory User3.fromJson(Map<String, dynamic> json) => _$User3FromJson(json);
//  Map<String, dynamic> toJson() => _$User3ToJson(this);
//}
