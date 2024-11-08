import 'package:flutter_take_home/src/features/dashboard/domain/entities/post.dart';

class PostModel {
  final int id;
  final int userId;
  final String title;
  final String body;

  PostModel({
    required this.id,
    required this.userId,
    required this.title,
    required this.body,
  });

  factory PostModel.fromJson(Map<String, dynamic> json) {
    return PostModel(
      id: json['id'],
      userId: json['userId'],
      title: json['title'],
      body: json['body'],
    );
  }

  Post toEntity() {
    return Post(
      id: id,
      userId: userId,
      title: title,
      body: body,
    );
  }

}