import 'package:fpdart/fpdart.dart';
import 'package:health_tracker_app/core/constants/constants.dart';
import 'package:health_tracker_app/core/enums/gender.dart';
import 'package:health_tracker_app/core/error/exceptions.dart';
import 'package:health_tracker_app/core/error/failure.dart';
import 'package:health_tracker_app/core/network/connection_checker.dart';
import 'package:health_tracker_app/features/auth/data/models/user_model.dart';
import 'package:health_tracker_app/features/profile/data/datasources/profile_remote_data_source.dart';
import 'package:health_tracker_app/features/profile/domain/repositories/profile_repository.dart';

class ProfileRepositoryImpl implements ProfileRepository {
  final ProfileRemoteDataSource _profileRemoteDataSource;
  final ConnectionChecker _connectionChecker;

  ProfileRepositoryImpl(this._profileRemoteDataSource, this._connectionChecker);

  @override
  Future<Either<Failure, UserModel>> updateUserBasicDetails({
    required int height,
    required int weight,
    required double bmi,
    required int age,
    required Gender gender,
  }) async {
    try {
      if (!await (_connectionChecker.isConnected)) {
        return left(Failure(Constants.noConnectionErrorMessage));
      }
      final user = await _profileRemoteDataSource.updateUserBasicDetails(
        height: height,
        weight: weight,
        bmi: bmi,
        age: age,
        gender: gender,
      );
      return right(user);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }
}
