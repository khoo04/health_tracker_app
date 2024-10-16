part of 'auth_bloc.dart';

@immutable
sealed class AuthEvent {}

final class AuthSignUp extends AuthEvent {
  final String email;
  final String password;
  final String firstName;
  final String lastName;

  AuthSignUp({
    required this.email,
    required this.password,
    required this.firstName,
    required this.lastName,
  });
}

final class AuthLogin extends AuthEvent {
  final String email;
  final String password;

  AuthLogin({required this.email, required this.password});
}
