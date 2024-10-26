import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:health_tracker_app/model/article_model.dart';

part 'artc_event.dart';
part 'artc_state.dart';

class ArtcBloc extends Bloc<ArtcEvent, ArtcState> {
  
  ArtcBloc() : super(ArtcInitial()) {
    on<ArtcFetch>((event, emit) async {
      emit(ArtcLoading());
      try {
        final articles = await Article.fetchArticle();
        emit(ArtcSuccess(articleList: articles));
      } catch (e) {
        emit(ArtcFailure(e.toString()));
      }
    });
  }
}
