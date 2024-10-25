import 'package:fpdart/fpdart.dart';
import 'package:health_tracker_app/core/enums/gender.dart';
import 'package:health_tracker_app/core/error/failure.dart';
import 'package:health_tracker_app/features/auth/data/models/user_model.dart';

abstract interface class ProfileRepository {
  Future<Either<Failure, UserModel>> updateUserBasicDetails({
    required int height,
    required int weight,
    required double bmi,
    required int age,
    required Gender gender,
  });
}
