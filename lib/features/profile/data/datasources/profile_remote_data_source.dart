import 'package:health_tracker_app/core/enums/gender.dart';
import 'package:health_tracker_app/core/error/exceptions.dart';
import 'package:health_tracker_app/core/utils/logger.dart';
import 'package:health_tracker_app/features/auth/data/models/user_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract interface class ProfileRemoteDataSource {
  Future<UserModel> updateUserBasicDetails({
    required int height,
    required int weight,
    required double bmi,
    required int age,
    required Gender gender,
  });
}

class ProfileRemoteDataSourceImp implements ProfileRemoteDataSource {
  final SupabaseClient supabaseClient;

  ProfileRemoteDataSourceImp(this.supabaseClient);
  @override
  Future<UserModel> updateUserBasicDetails({
    required int height,
    required int weight,
    required double bmi,
    required int age,
    required Gender gender,
  }) async {
    try {
      String userId = supabaseClient.auth.currentUser!.id;
      String genderToUpdate;
      if (gender == Gender.female) {
        genderToUpdate = "female";
      } else {
        genderToUpdate = "male";
      }
      final response = await supabaseClient
          .from('users')
          .update({
            "height": height,
            "weight": weight,
            "bmi": bmi,
            "age": age,
            "sex": genderToUpdate,
          })
          .eq('user_id', userId)
          .select();

      return UserModel.fromJson(response.first);
    } catch (e) {
      eLog(e.toString());
      throw ServerException(e.toString());
    }
  }
}
