import 'package:json_annotation/json_annotation.dart';

part 'post.g.dart';

@JsonSerializable()
class Post {
  final String authorEmail;
  final String authorImageUrl;
  final String description;
  final String postImageUrl;
  final String id;

  List likes = [];

  Post({
    required this.authorImageUrl,
    required this.id,
    required this.authorEmail,
    required this.description,
    required this.postImageUrl,
  });

  factory Post.fromJson(Map<String, dynamic> json) => _$PostFromJson(json);

  Map<String, dynamic> toJson() => _$PostToJson(this);
}
