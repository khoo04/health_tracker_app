import 'package:fpdart/fpdart.dart';
import 'package:health_tracker_app/core/error/failure.dart';
import 'package:health_tracker_app/features/articles/data/models/article_model.dart';

abstract interface class ArticleRepository {
  Future<Either<Failure, List<ArticleModel>>> fetchArticle();
}
