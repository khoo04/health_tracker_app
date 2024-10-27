import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeInitial()) {
    on<LevelPressed>((event, emit) {
      emit(ToRoutine(
          liter: event.liter, step: event.step, calories: event.calories));
    });
    on<BackPressed>((event, emit) {
      emit(ToLevel());
    });
  }
}
