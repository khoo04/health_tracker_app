part of 'home_bloc.dart';

@immutable
sealed class HomeState {}

final class HomeInitial extends HomeState {}

final class ToRoutine extends HomeState {
  final double liter;
  final int step;
  final int calories;

  ToRoutine({
    required this.liter,
    required this.step,
    required this.calories,
  });
}

final class ToLevel extends HomeState {}
