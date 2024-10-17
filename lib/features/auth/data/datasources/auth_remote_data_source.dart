import 'package:health_tracker_app/core/common/response/success.dart';
import 'package:health_tracker_app/core/error/exceptions.dart';
import 'package:health_tracker_app/core/utils/logger.dart';
import 'package:health_tracker_app/features/auth/data/models/user_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract interface class AuthRemoteDataSource {
  Session? get currentUserSession;

  Future<UserModel> signUpWithEmailPassword({
    required String firstName,
    required String lastName,
    required String email,
    required String password,
  });

  Future<UserModel> loginWithEmailPassword({
    required String email,
    required String password,
  });
  Future<UserModel?> getCurrentUserData();

  Future<Success?> logoutUser();
}

class AuthRemoteDataSourceImp implements AuthRemoteDataSource {
  final SupabaseClient supabaseClient;
  AuthRemoteDataSourceImp(this.supabaseClient);

  @override
  Future<UserModel> loginWithEmailPassword({
    required String email,
    required String password,
  }) async {
    try {
      final response = await supabaseClient.auth.signInWithPassword(
        password: password,
        email: email,
      );

      if (response.user == null) {
        throw const ServerException('User is null!');
      }
      return UserModel.fromJson(response.user!.toJson());
    } on AuthException catch (e) {
      throw ServerException(e.message);
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<UserModel> signUpWithEmailPassword({
    required String firstName,
    required String lastName,
    required String email,
    required String password,
  }) async {
    try {
      final response = await supabaseClient.auth.signUp(
        password: password,
        email: email,
        data: {
          'first_name': firstName,
          'last_name': lastName,
        },
      );

      if (response.user == null) {
        throw const ServerException('User is null!');
      }
      return UserModel.fromJson(response.user!.toJson());
    } on AuthException catch (e) {
      throw ServerException(e.message);
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Session? get currentUserSession => supabaseClient.auth.currentSession;

  @override
  Future<UserModel?> getCurrentUserData() async {
    try {
      if (currentUserSession != null) {
        final userData = await supabaseClient
            .from('users')
            .select()
            .eq('user_id', currentUserSession!.user.id);
        eLog(userData);
        return UserModel.fromJson(userData.first).copyWith(
          email: currentUserSession!.user.email,
        );
      }
      return null;
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<Success?> logoutUser() async {
    try {
      await supabaseClient.auth.signOut();
      return Success('User logout successfully');
    } on AuthException catch (e) {
      throw ServerException(e.message);
    } catch (e) {
      throw ServerException(e.toString());
    }
  }
}
