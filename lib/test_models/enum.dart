import 'package:json_annotation/json_annotation.dart';
//@JsonSerializable()
//part of 'User2.dart';

enum UserType {
  @JsonValue(0)
  none,
  @JsonValue(1)
  student,
  @JsonValue(2)
  teacher,
}

enum UserTypeTest {
  none,
  student,
  teacher,
}
