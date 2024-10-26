part of 'artc_bloc.dart';

@immutable
sealed class ArtcState {}

final class ArtcInitial extends ArtcState {}

final class ArtcSuccess extends ArtcState {
  final List<Article> articleList;

  ArtcSuccess({required this.articleList});
}

final class ArtcFailure extends ArtcState {
  final String artcError;

  ArtcFailure(this.artcError);
}

final class ArtcLoading extends ArtcState {}
