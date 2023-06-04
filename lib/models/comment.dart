import 'package:json_annotation/json_annotation.dart';

part 'comment.g.dart';

@JsonSerializable()
class Comment {
  final String authorName;
  final String authorImageUrl;
  final String text;

  Comment({
    required this.authorName,
    required this.authorImageUrl,
    required this.text,
  });

  factory Comment.fromJson(Map<String, dynamic> json) =>
      _$CommentFromJson(json);

  Map<String, dynamic> toJson() => _$CommentToJson(this);
}
