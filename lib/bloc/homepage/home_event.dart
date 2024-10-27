part of 'home_bloc.dart';

@immutable
sealed class HomeEvent {}

class LevelPressed extends HomeEvent {
  final double Liter;
  final int Step;
  final int Calories;
  

  LevelPressed(
      {required this.Liter,
      required this.Step,
      required this.Calories,
      });
}

class BackPressed extends HomeEvent {}
