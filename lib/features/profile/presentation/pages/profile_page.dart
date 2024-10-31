import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:health_tracker_app/core/common/cubits/app_user/app_user_cubit.dart';
import 'package:health_tracker_app/core/common/widgets/loader.dart';
import 'package:health_tracker_app/core/theme/app_pallete.dart';
import 'package:health_tracker_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class ProfilePage extends StatelessWidget {
  static const String routeName = "/profile";
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthInitial) {
          Navigator.of(context).pop();
        }
      },
      builder: (context, state) {
        if (state is AuthLoading) {
          return const Scaffold(
            body: Loader(),
          );
        }
        return Scaffold(
          backgroundColor: Colors.grey[100],
          body: NestedScrollView(
            headerSliverBuilder: (context, innerBoxIsScrolled) => [
              SliverAppBar(
                backgroundColor: AppPallete.whiteColor,
                leadingWidth: 80,
                leading: IconButton.filled(
                  color: Colors.white,
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  icon: const Icon(
                    Icons.arrow_back_ios_new,
                  ),
                  alignment: Alignment.center,
                  style: IconButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    backgroundColor: AppPallete.greyColor,
                  ),
                ),
              ),
            ],
            body: SingleChildScrollView(
              child: BlocBuilder<AppUserCubit, AppUserState>(
                builder: (context, state) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(vertical: 12.0),
                        color: Colors.white,
                        child: Column(
                          children: [
                            Container(
                              height: 120,
                              width: 120,
                              decoration: const BoxDecoration(
                                color: AppPallete.primaryColor,
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(
                                Icons.favorite,
                                color: AppPallete.secondaryColor,
                                size: 64,
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  state is AppUserLoggedIn
                                      ? "${state.user.firstName} ${state.user.lastName}"
                                      : "Username",
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                LinearPercentIndicator(
                                  width:
                                      MediaQuery.of(context).size.width * 0.6,
                                  lineHeight: 24.0,
                                  percent: 0.10,
                                  center: const Text(
                                    "1",
                                    style: TextStyle(
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.bold,
                                      color: AppPallete.whiteColor,
                                    ),
                                  ),
                                  barRadius: const Radius.circular(12.0),
                                  backgroundColor: Colors.grey,
                                  progressColor: AppPallete.primaryColor,
                                ),
                              ],
                            ),
                            const SizedBox(height: 5),
                            const Text("10/100 XP"),
                            const SizedBox(height: 5),
                            Text(
                              state is AppUserLoggedIn
                                  ? state.user.email
                                  : "Email",
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.all(12.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ListTile(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                              contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 12, vertical: 8.0),
                              leading: Container(
                                decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: AppPallete.secondaryColor),
                                height: 50,
                                width: 50,
                                child: const Icon(
                                  Icons.widgets,
                                  color: AppPallete.primaryColor,
                                ),
                              ),
                              title: const Text("Change BMI"),
                              trailing: const Icon(Icons.arrow_forward_ios),
                              tileColor: AppPallete.whiteColor,
                              onTap: () => {print("Go change BMI Page")},
                            ),
                            const SizedBox(height: 15),
                            ListTile(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                              contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 12, vertical: 8.0),
                              leading: Container(
                                decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: AppPallete.secondaryColor),
                                height: 50,
                                width: 50,
                                child: const Icon(
                                  Icons.dark_mode,
                                  color: AppPallete.primaryColor,
                                ),
                              ),
                              title: const Text("Dark Mode"),
                              trailing: Switch(
                                value: false,
                                inactiveThumbColor: Colors.white,
                                inactiveTrackColor: Colors.grey[400],
                                activeColor: AppPallete.secondaryColor,
                                activeTrackColor: AppPallete.primaryColor,
                                onChanged: (value) => {print("Do something")},
                              ),
                              tileColor: AppPallete.whiteColor,
                            ),
                            const SizedBox(height: 15),
                            ListTile(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                              contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 12, vertical: 8.0),
                              leading: Container(
                                decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: AppPallete.secondaryColor),
                                height: 50,
                                width: 50,
                                child: const Icon(
                                  Icons.restart_alt,
                                  color: AppPallete.primaryColor,
                                ),
                              ),
                              title: const Text("Reset Level"),
                              trailing: const Icon(Icons.arrow_forward_ios),
                              tileColor: AppPallete.whiteColor,
                              onTap: () => {print("Go change BMI Page")},
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            const Padding(
                              padding: EdgeInsets.symmetric(horizontal: 8.0),
                              child: Text(
                                "Reset Password",
                                style: TextStyle(
                                    fontSize: 18.0, color: Colors.black54),
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            GestureDetector(
                              onTap: () {
                                context.read<AuthBloc>().add(AuthLogout());
                              },
                              child: const Padding(
                                padding: EdgeInsets.symmetric(horizontal: 8.0),
                                child: Text(
                                  "Log out",
                                  style: TextStyle(
                                      fontSize: 18.0, color: Colors.black54),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            const Padding(
                              padding: EdgeInsets.symmetric(horizontal: 8.0),
                              child: Text(
                                "Delete account",
                                style: TextStyle(
                                    fontSize: 18.0, color: Colors.red),
                              ),
                            ),
                            //Reserve Space for Small Screen to enable scrolling
                            const SizedBox(
                              height: 150,
                            ),
                          ],
                        ),
                      )
                    ],
                  );
                },
              ),
            ),
          ),
        );
      },
    );
  }
}
