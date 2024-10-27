import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:health_tracker_app/core/common/cubits/app_user/app_user_cubit.dart';
import 'package:health_tracker_app/core/theme/app_pallete.dart';
import 'package:health_tracker_app/features/articles/presentation/pages/article_page.dart';
import 'package:health_tracker_app/features/home/presentation/pages/home_page.dart';
import 'package:health_tracker_app/features/profile/presentation/pages/profile_page.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class AppFrame extends StatefulWidget {
  const AppFrame({super.key});

  @override
  State<AppFrame> createState() => _AppFrameState();
}

class _AppFrameState extends State<AppFrame> {
  List<Widget> pages = const [
    HomePage(),
    ArticlePage(),
  ];
  int currIndex = 0;

  void changeIndex(int index) {
    setState(() {
      currIndex = index;
    });
  }

  Widget bottomNaviIcon({required IconData icon, required int index}) {
    return Expanded(
      child: GestureDetector(
        onTap: () => setState(() {
          currIndex = index;
        }),
        child: Center(
          child: Icon(
            icon,
            size: 35,
            color: index == currIndex ? AppPallete.primaryColor : null,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppUserCubit, AppUserState>(
      builder: (context, state) {
        return Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: AppBar(
            backgroundColor: AppPallete.whiteColor,
            scrolledUnderElevation: 0,
            toolbarHeight: 80,
            title: GestureDetector(
              onTap: () {
                Navigator.of(context).pushNamed(ProfilePage.routeName);
              },
              child: Row(
                children: [
                  const CircleAvatar(
                    backgroundColor: AppPallete.primaryColor,
                    radius: 30,
                    child: Icon(
                      Icons.favorite,
                      size: 35,
                      color: AppPallete.secondaryColor,
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          state is AppUserLoggedIn
                              ? "${state.user.firstName} ${state.user.lastName}"
                              : "Username",
                          style: const TextStyle(fontSize: 17),
                        ),
                        const Text(
                          "Lvl. 24",
                          style: TextStyle(fontSize: 15),
                        ),
                        LinearPercentIndicator(
                          padding: const EdgeInsets.all(0),
                          barRadius: const Radius.circular(12.0),
                          lineHeight: 15,
                          width: 150,
                          percent: 0.73,
                          progressColor: AppPallete.primaryColor,
                        ),
                        const SizedBox(height: 5),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            bottom: const PreferredSize(
              preferredSize: Size.fromHeight(4.0), // Height of the divider
              child: Divider(
                  thickness: 4,
                  height: 4,
                  color: Color.fromARGB(255, 222, 225, 230)),
            ),
          ),
          body: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              pages[currIndex],
              Positioned(
                bottom: 10,
                child: Container(
                  margin: const EdgeInsets.only(bottom: 10),
                  height: 80,
                  width: 330,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(40),
                      color: const Color.fromARGB(255, 222, 225, 230)),
                  child: Row(
                    children: [
                      bottomNaviIcon(icon: Icons.home, index: 0),
                      bottomNaviIcon(icon: Icons.article, index: 1),
                    ],
                  ),
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
