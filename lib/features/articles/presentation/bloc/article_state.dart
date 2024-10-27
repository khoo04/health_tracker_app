part of 'article_bloc.dart';

@immutable
sealed class ArticleState {
  const ArticleState();
}

final class ArticleInitial extends ArticleState {}

final class ArticleSuccess extends ArticleState {
  final List<Article> articleList;

  const ArticleSuccess(this.articleList);
}

final class ArticleFailure extends ArticleState {
  final String error;
  const ArticleFailure(this.error);
}

final class ArticleLoading extends ArticleState {}
