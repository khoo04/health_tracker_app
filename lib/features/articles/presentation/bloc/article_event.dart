part of 'article_bloc.dart';

@immutable
sealed class ArticleEvent {}

final class ArticleFetch extends ArticleEvent {}

final class ArticleFilter extends ArticleEvent {
  final String keyword;

  ArticleFilter(this.keyword);
}
