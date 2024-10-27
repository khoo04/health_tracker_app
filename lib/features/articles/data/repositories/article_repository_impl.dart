import 'package:fpdart/fpdart.dart';
import 'package:health_tracker_app/core/constants/constants.dart';
import 'package:health_tracker_app/core/error/exceptions.dart';
import 'package:health_tracker_app/core/error/failure.dart';
import 'package:health_tracker_app/core/network/connection_checker.dart';
import 'package:health_tracker_app/features/articles/data/datasources/article_remote_data_source.dart';
import 'package:health_tracker_app/features/articles/data/models/article_model.dart';
import 'package:health_tracker_app/features/articles/domain/repositories/article_repository.dart';

class ArticleRepositoryImpl implements ArticleRepository {
  final ArticleRemoteDataSource _articleRemoteDataSource;
  final ConnectionChecker _connectionChecker;

  ArticleRepositoryImpl(this._articleRemoteDataSource, this._connectionChecker);
  @override
  Future<Either<Failure, List<ArticleModel>>> fetchArticle() async {
    try {
      if (!await (_connectionChecker.isConnected)) {
        return left(Failure(Constants.noConnectionErrorMessage));
      }
      final articles = await _articleRemoteDataSource.fetchArticle();
      return right(articles);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }
}
