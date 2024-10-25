part of 'profile_bloc.dart';

@immutable
sealed class ProfileState {
  const ProfileState();
}

final class ProfileInitial extends ProfileState {}

final class ProfileFailure extends ProfileState {
  final String message;
  const ProfileFailure(this.message);
}

final class ProfileLoading extends ProfileState {}

final class ProfileSuccess extends ProfileState {
  final String message;
  const ProfileSuccess(this.message);
}
