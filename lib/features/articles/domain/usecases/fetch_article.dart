import 'package:fpdart/fpdart.dart';
import 'package:health_tracker_app/core/error/failure.dart';
import 'package:health_tracker_app/core/usecase/usecase.dart';
import 'package:health_tracker_app/features/articles/domain/entities/article.dart';
import 'package:health_tracker_app/features/articles/domain/repositories/article_repository.dart';

class FetchArticle implements UseCase<List<Article>, NoParams> {
  final ArticleRepository _articleRepository;
  const FetchArticle(this._articleRepository);
  @override
  Future<Either<Failure, List<Article>>> call(NoParams params) async {
    return await _articleRepository.fetchArticle();
  }
}
