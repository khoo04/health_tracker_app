part of 'profile_bloc.dart';

@immutable
sealed class ProfileEvent {}

final class ProfileUpdateBasicDetails extends ProfileEvent {
  final int height;
  final int weight;
  final double bmi;
  final int age;
  final Gender gender;

  ProfileUpdateBasicDetails({
    required this.height,
    required this.weight,
    required this.bmi,
    required this.age,
    required this.gender,
  });
}
