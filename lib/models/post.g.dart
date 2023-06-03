// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Post _$PostFromJson(Map<String, dynamic> json) => Post(
      authorImageUrl: json['authorImageUrl'] as String,
      id: json['id'] as String,
      authorEmail: json['authorEmail'] as String,
      description: json['description'] as String,
      postImageUrl: json['postImageUrl'] as String,
    )..likes = json['likes'] as List<dynamic>;

Map<String, dynamic> _$PostToJson(Post instance) => <String, dynamic>{
      'authorEmail': instance.authorEmail,
      'authorImageUrl': instance.authorImageUrl,
      'description': instance.description,
      'postImageUrl': instance.postImageUrl,
      'id': instance.id,
      'likes': instance.likes,
    };
