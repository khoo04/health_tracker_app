import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:health_tracker_app/core/usecase/usecase.dart';
import 'package:health_tracker_app/core/utils/logger.dart';
import 'package:health_tracker_app/features/articles/domain/entities/article.dart';
import 'package:health_tracker_app/features/articles/domain/usecases/fetch_article.dart';

part 'article_event.dart';
part 'article_state.dart';

class ArticleBloc extends Bloc<ArticleEvent, ArticleState> {
  //Use Cases
  final FetchArticle _fetchArticle;
  List<Article> _fetchedArticles = []; // Store original fetched article
  ArticleBloc({
    required FetchArticle fetchArticle,
  })  : _fetchArticle = fetchArticle,
        super(ArticleInitial()) {
    on<ArticleFetch>((event, emit) async {
      emit(ArticleLoading());
      final response = await _fetchArticle(NoParams());
      response.fold(
        (l) => emit(ArticleFailure(l.message)),
        (articles) {
          _fetchedArticles = articles;
          emit(ArticleSuccess(articles));
        },
      );
    });
    on<ArticleFilter>((event, emit) {
      if (state is ArticleSuccess) {
        final filteredArticles = List<Article>.from(_fetchedArticles.where(
            (article) => article.title
                .toLowerCase()
                .contains(event.keyword.toLowerCase())));

        emit(ArticleSuccess(filteredArticles)); // Emit the filtered articles
      }
    });
  }
}
