part of 'home_bloc.dart';

@immutable
sealed class HomeEvent {}

class LevelPressed extends HomeEvent {
  final double liter;
  final int step;
  final int calories;

  LevelPressed({
    required this.liter,
    required this.step,
    required this.calories,
  });
}

class BackPressed extends HomeEvent {}
