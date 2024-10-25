import 'package:fpdart/fpdart.dart';
import 'package:health_tracker_app/core/common/entities/user.dart';
import 'package:health_tracker_app/core/enums/gender.dart';
import 'package:health_tracker_app/core/error/failure.dart';
import 'package:health_tracker_app/core/usecase/usecase.dart';
import 'package:health_tracker_app/features/profile/domain/repositories/profile_repository.dart';

class UpdateBasicDetails
    implements UseCase<User, UserUpdateBasicDetailsParams> {
  final ProfileRepository _profileRepository;
  const UpdateBasicDetails(this._profileRepository);
  @override
  Future<Either<Failure, User>> call(
      UserUpdateBasicDetailsParams params) async {
    return await _profileRepository.updateUserBasicDetails(
      height: params.height,
      weight: params.weight,
      bmi: params.bmi,
      age: params.age,
      gender: params.gender,
    );
  }
}

class UserUpdateBasicDetailsParams {
  final int height;
  final int weight;
  final double bmi;
  final int age;
  final Gender gender;

  UserUpdateBasicDetailsParams({
    required this.height,
    required this.weight,
    required this.bmi,
    required this.age,
    required this.gender,
  });
}
