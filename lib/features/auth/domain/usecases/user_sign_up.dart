import 'package:fpdart/fpdart.dart';
import 'package:health_tracker_app/core/common/entities/user.dart';
import 'package:health_tracker_app/core/error/failure.dart';
import 'package:health_tracker_app/core/usecase/usecase.dart';
import 'package:health_tracker_app/features/auth/domain/repositories/auth_repository.dart';

class UserSignUp implements UseCase<User, UserSignUpParams> {
  final AuthRepository _authRepository;
  const UserSignUp(this._authRepository);
  @override
  Future<Either<Failure, User>> call(UserSignUpParams params) async {
    return await _authRepository.signUpWithEmailPassword(
        firstName: params.firstName,
        lastName: params.lastName,
        email: params.email,
        password: params.password);
  }
}

class UserSignUpParams {
  final String firstName;
  final String lastName;
  final String email;
  final String password;

  UserSignUpParams(
      {required this.firstName,
      required this.lastName,
      required this.email,
      required this.password});
}
