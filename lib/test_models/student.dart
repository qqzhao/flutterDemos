import 'package:json_annotation/json_annotation.dart';

import 'user.dart';

@JsonSerializable(explicitToJson: true, anyMap: true)
class Student extends User2 {
  List<User2> classmates;
  num grade;
  Student(this.classmates, this.grade) : super(null, '', null);
}
