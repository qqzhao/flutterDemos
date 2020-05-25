import 'package:json_annotation/json_annotation.dart';

import 'tag.dart';
import './user/user.dart';

part 'testUser.g.dart';

@JsonSerializable()
class TestUser {
      TestUser();

  int id;
  String title;
  String content;
  List<Tag> tags;
  User user;
  bool published;

  factory TestUser.fromJson(Map<String,dynamic> json) => _$TestUserFromJson(json);
  Map<String, dynamic> toJson() => _$TestUserToJson(this);
  

}


