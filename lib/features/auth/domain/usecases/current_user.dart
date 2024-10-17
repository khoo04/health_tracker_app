import 'package:fpdart/fpdart.dart';
import 'package:health_tracker_app/core/common/entities/user.dart';
import 'package:health_tracker_app/core/error/failure.dart';
import 'package:health_tracker_app/core/usecase/usecase.dart';
import 'package:health_tracker_app/features/auth/domain/repositories/auth_repository.dart';

class CurrentUser implements UseCase<User, NoParams> {
  final AuthRepository _authRepository;
  const CurrentUser(this._authRepository);
  @override
  Future<Either<Failure, User>> call(NoParams params) {
    return _authRepository.currentUser();
  }
}
