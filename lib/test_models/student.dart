import 'package:json_annotation/json_annotation.dart';

import 'User2.dart';
import 'enum.dart';

part 'student.g.dart';

@JsonSerializable(explicitToJson: true, anyMap: true)
class Student extends User2 {
  List<User2> classmates;
  num grade;
  Student({this.classmates, this.grade}) : super();

  factory Student.fromJson(Map<String, dynamic> json) => _$StudentFromJson(json);
  Map<String, dynamic> toJson() => _$StudentToJson(this);
}
