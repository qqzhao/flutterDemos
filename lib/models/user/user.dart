import 'package:json_annotation/json_annotation.dart';



part 'user.g.dart';

@JsonSerializable()
class User {
      User();

  int id;
  String schoolName;
  String name;
  int age;

  factory User.fromJson(Map<String,dynamic> json) => _$UserFromJson(json);
  Map<String, dynamic> toJson() => _$UserToJson(this);
}