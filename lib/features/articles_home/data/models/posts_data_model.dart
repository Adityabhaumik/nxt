import 'dart:convert';

import 'package:nxt/features/articles_home/domain/entities/post_data_enitity.dart';

class ArticleDataModel {
  final int userId;
  final int id;
  final String title;
  final String body;

  ArticleDataModel({
    required this.userId,
    required this.id,
    required this.title,
    required this.body,
  });

  factory ArticleDataModel.fromJson(Map<String, dynamic> json) {
    return ArticleDataModel(
      userId: json['userId'] as int,
      id: json['id'] as int,
      title: json['title'] as String,
      body: json['body'] as String,
    );
  }

  static String toJson(ArticleDataModel model) {
    final data = {
      'userId': model.userId,
      'id': model.id,
      'title': model.title,
      'body': model.body,
    };
    return json.encode(data);
  }

  @override
  String toString() {
    return 'Post(userId: $userId, id: $id, title: $title, body: $body)';
  }

  static ArticleDataEnitity toEntity(ArticleDataModel model) {
    return ArticleDataEnitity(
        body: model.body, id: model.id, title: model.title, userId: model.id);
  }

  static ArticleDataModel fromEntity(ArticleDataEnitity entity) {
    return ArticleDataModel(
        userId: entity.userId,
        id: entity.id,
        title: entity.title,
        body: entity.body);
  }
}
