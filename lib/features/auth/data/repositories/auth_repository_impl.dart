import 'package:fpdart/fpdart.dart';
import 'package:health_tracker_app/core/common/entities/user.dart';
import 'package:health_tracker_app/core/common/response/success.dart';
import 'package:health_tracker_app/core/constants/constants.dart';
import 'package:health_tracker_app/core/error/exceptions.dart';
import 'package:health_tracker_app/core/error/failure.dart';
import 'package:health_tracker_app/core/network/connection_checker.dart';
import 'package:health_tracker_app/core/utils/logger.dart';
import 'package:health_tracker_app/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:health_tracker_app/features/auth/data/models/user_model.dart';
import 'package:health_tracker_app/features/auth/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource _authRemoteDataSource;
  final ConnectionChecker _connectionChecker;

  AuthRepositoryImpl(this._authRemoteDataSource, this._connectionChecker);

  @override
  Future<Either<Failure, User>> currentUser() async {
    try {
      //Trigger when not internet connection
      if (!await (_connectionChecker.isConnected)) {
        final session = _authRemoteDataSource.currentUserSession;
        if (session == null) {
          return left(Failure('User not logged in'));
        }
        return right(UserModel(
            id: session.user.id,
            email: session.user.email ?? '',
            firstName: '',
            lastName: ''));
      }

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
      return left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, Success?>> logoutUser() async {
    try {
      if (!await (_connectionChecker.isConnected)) {
        return left(Failure(Constants.noConnectionErrorMessage));
      }
      final isSuccess = await _authRemoteDataSource.logoutUser();
      return right(isSuccess);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }
}
