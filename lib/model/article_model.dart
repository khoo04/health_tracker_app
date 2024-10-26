import 'package:supabase_flutter/supabase_flutter.dart';

class Article {
  String imageUrl;
  String title;
  String content;
  String dateCreate;
  bool isAds;

  Article(
      {required this.imageUrl,
      required this.title,
      required this.content,
      required this.dateCreate,
      required this.isAds});

  factory Article.fromMap(Map<String, dynamic> map) {
    return Article(
        imageUrl: map['imageUrl'],
        title: map['title'],
        content: map['content'],
        dateCreate: map['dateCreate'],
        isAds: map['isAds']);
  }

  static Future<List<Article>> fetchArticle() async {
    final response = await Supabase.instance.client.from('articles').select();

    return response.map((data) => Article.fromMap(data)).toList();
  }
}
