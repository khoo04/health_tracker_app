import 'package:health_tracker_app/core/error/exceptions.dart';
import 'package:health_tracker_app/core/utils/logger.dart';
import 'package:health_tracker_app/features/articles/data/models/article_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract interface class ArticleRemoteDataSource {
  Future<List<ArticleModel>> fetchArticle();
}

class ArticleRemoteDataSourceImp implements ArticleRemoteDataSource {
  final SupabaseClient supabaseClient;

  ArticleRemoteDataSourceImp(this.supabaseClient);

  @override
  Future<List<ArticleModel>> fetchArticle() async {
    try {
      final response = await supabaseClient.from('articles').select();
      return response.map((data) => ArticleModel.fromJson(data)).toList();
    } catch (e) {
      eLog(e.toString());
      throw ServerException(e.toString());
    }
  }
}
