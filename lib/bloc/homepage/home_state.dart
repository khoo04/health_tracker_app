part of 'home_bloc.dart';

@immutable
sealed class HomeState {}

final class HomeInitial extends HomeState {}

final class ToRoutine extends HomeState {
  final double Liter;
  final int Step;
  final int Calories;

  ToRoutine({
    required this.Liter,
    required this.Step,
    required this.Calories,
  });
}

final class ToLevel extends HomeState {}
