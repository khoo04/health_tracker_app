import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/foundation.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeInitial()) {
    on<LevelPressed>((event, emit) {
      emit(ToRoutine(
        Liter: event.Liter,
        Step: event.Step,
        Calories: event.Calories,
      ));
    });

    on<BackPressed>((event, emit) {
      emit(ToLevel());
    });
  }
}
