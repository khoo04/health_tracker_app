import 'package:fpdart/fpdart.dart';
import 'package:health_tracker_app/core/common/response/success.dart';
import 'package:health_tracker_app/core/error/failure.dart';
import 'package:health_tracker_app/core/usecase/usecase.dart';
import 'package:health_tracker_app/features/auth/domain/repositories/auth_repository.dart';

class UserLogout implements UseCase<Success?, NoParams> {
  final AuthRepository _authRepository;
  const UserLogout(this._authRepository);
  @override
  Future<Either<Failure, Success?>> call(NoParams params) {
    return _authRepository.logoutUser();
  }
}
