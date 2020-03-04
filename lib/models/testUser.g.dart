// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'testUser.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TestUser _$TestUserFromJson(Map<String, dynamic> json) {
  return TestUser()
    ..id = json['id'] as int
    ..title = json['title'] as String
    ..content = json['content'] as String
    ..tags = (json['tags'] as List)
        ?.map((e) => e == null ? null : Tag.fromJson(e as Map<String, dynamic>))
        ?.toList()
    ..user = json['user'] == null
        ? null
        : User.fromJson(json['user'] as Map<String, dynamic>)
    ..published = json['published'] as bool;
}

Map<String, dynamic> _$TestUserToJson(TestUser instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'content': instance.content,
      'tags': instance.tags,
      'user': instance.user,
      'published': instance.published,
    };
