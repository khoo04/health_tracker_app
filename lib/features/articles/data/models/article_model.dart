import 'package:health_tracker_app/features/articles/domain/entities/article.dart';

class ArticleModel extends Article {
  ArticleModel(
      {required super.imageUrl,
      required super.title,
      required super.content,
      required super.dateCreate,
      required super.isAds});

  factory ArticleModel.fromJson(Map<String, dynamic> map) {
    return ArticleModel(
        imageUrl: map['imageUrl'],
        title: map['title'],
        content: map['content'],
        dateCreate: DateTime.parse(map['dateCreate']),
        isAds: map['isAds']);
  }
}
