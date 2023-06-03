// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'comment.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Comment _$CommentFromJson(Map<String, dynamic> json) => Comment(
      authorName: json['authorName'] as String,
      authorImageUrl: json['authorImageUrl'] as String,
      text: json['text'] as String,
    );

Map<String, dynamic> _$CommentToJson(Comment instance) => <String, dynamic>{
      'authorName': instance.authorName,
      'authorImageUrl': instance.authorImageUrl,
      'text': instance.text,
    };
