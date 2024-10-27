import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:health_tracker_app/features/home/presentation/pages/level_page.dart';
import 'package:health_tracker_app/features/home/presentation/pages/routine_page.dart';

import '../bloc/home_bloc.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(builder: (context, state) {
      if (state is ToRoutine) {
        return RoutinePage(
            goalLiters: state.liter,
            goalSteps: state.step,
            goalCalories: state.calories);
      } else {
        return const LevelPage();
      }
    });
  }
}
