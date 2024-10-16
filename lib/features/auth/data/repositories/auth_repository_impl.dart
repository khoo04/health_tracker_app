import 'package:fpdart/src/either.dart';
import 'package:health_tracker_app/core/common/entities/user.dart';
import 'package:health_tracker_app/core/constants/constants.dart';
import 'package:health_tracker_app/core/error/exceptions.dart';
import 'package:health_tracker_app/core/error/failure.dart';
import 'package:health_tracker_app/core/network/connection_checker.dart';
import 'package:health_tracker_app/core/utils/logget.dart';
import 'package:health_tracker_app/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:health_tracker_app/features/auth/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource _authRemoteDataSource;
  final ConnectionChecker _connectionChecker;

  AuthRepositoryImpl(this._authRemoteDataSource, this._connectionChecker);

  @override
  Future<Either<Failure, User>> currentUser() async {
    try {
      final user = await _authRemoteDataSource.getCurrentUserData();

      if (user == null) {
        return left(Failure("User not logged in"));
      }
      return right(user);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, User>> loginWithEmailPassword(
      {required String email, required String password}) async {
    try {
      if (!await (_connectionChecker.isConnected)) {
        return left(Failure(Constants.noConnectionErrorMessage));
      }
      final user = await _authRemoteDataSource.loginWithEmailPassword(
          email: email, password: password);

      return right(user);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, User>> signUpWithEmailPassword(
      {required String firstName,
      required String lastName,
      required String email,
      required String password}) async {
    try {
      if (!await (_connectionChecker.isConnected)) {
        return left(Failure(Constants.noConnectionErrorMessage));
      }
      final user = await _authRemoteDataSource.signUpWithEmailPassword(
          firstName: firstName,
          lastName: lastName,
          email: email,
          password: password);

      return right(user);
    } on ServerException catch (e) {
      eLog(e.toString());
      return left(Failure(e.message));
    }
  }
}
