import 'package:json_annotation/json_annotation.dart';

part 'User2.g.dart';

enum UserType {
  none,
  student,
  teacher,
  parents,
}

@JsonSerializable(explicitToJson: true, anyMap: true)
class User2 {
  UserType type;
  String name;
  num age;

//  User2(this.type, this.name, this.age);
}
