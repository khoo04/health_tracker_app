import 'package:get_it/get_it.dart';
import 'package:health_tracker_app/core/common/cubits/app_user/app_user_cubit.dart';
import 'package:health_tracker_app/core/network/connection_checker.dart';
import 'package:health_tracker_app/core/secrets/app_secrets.dart';
import 'package:health_tracker_app/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:health_tracker_app/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:health_tracker_app/features/auth/domain/repositories/auth_repository.dart';
import 'package:health_tracker_app/features/auth/domain/usecases/user_login.dart';
import 'package:health_tracker_app/features/auth/domain/usecases/user_sign_up.dart';
import 'package:health_tracker_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'init_dependencies_main.dart';