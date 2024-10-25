import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:health_tracker_app/core/common/cubits/app_user/app_user_cubit.dart';
import 'package:health_tracker_app/core/common/entities/user.dart';
import 'package:health_tracker_app/core/common/pages/dashboard.dart';
import 'package:health_tracker_app/core/utils/logger.dart';
import 'package:health_tracker_app/features/auth/presentation/pages/login_page.dart';
import 'package:health_tracker_app/features/profile/presentation/pages/bmi_details_page.dart';
import 'package:health_tracker_app/features/profile/presentation/pages/profile_page.dart';

class AppWrapper extends StatefulWidget {
  const AppWrapper({super.key});

  @override
  State<AppWrapper> createState() => _AppWrapperState();
}

class _AppWrapperState extends State<AppWrapper> {
  /// Empty Dashboard That Implements the Logout Function
  @override
  Widget build(BuildContext context) {
    return BlocSelector<AppUserCubit, AppUserState, User?>(selector: (state) {
      if (state is AppUserLoggedIn) {
        vLog(state.user);
        return state.user;
      }
      return null;
    }, builder: (context, user) {
      if (user != null) {
        //Check user bmi is define or not
        if (user.age == null ||
            user.bmi == null ||
            user.height == null ||
            user.weight == null ||
            user.sex == null) {
          vLog(user);
          return const BmiDetailsPage();
        }
        //TODO: Should return to Dashboard
        return const ProfilePage();
      } else {
        // If no user is logged in, show the login screen
        return const LoginPage();
      }
    });
  }
}
