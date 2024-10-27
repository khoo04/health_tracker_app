import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:health_tracker_app/bloc/homepage/home_bloc.dart';
import 'package:health_tracker_app/main.dart';
import 'package:health_tracker_app/pages/homepage/routine.dart';

class Bridge extends StatelessWidget {
  const Bridge({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(builder: (context, state) {
      if (state is ToRoutine) {
        return RoutinePage(
            goalLiters: state.Liter,
            goalSteps: state.Step,
            goalCalories: state.Calories);
      } else {
        return LevelPage();
      }
    });
  }
}

class LevelPage extends StatelessWidget {
  const LevelPage({super.key});

  @override
  Widget build(BuildContext context) {
    ScrollController scrollController = ScrollController();

    int currentlevel = 7;
    double mainLiter = 3 / 7;
    double mainStep = 2500 / 7;
    double mainCalorie = 3000 / 7;

    Widget levelContainer({required int index}) {
      return Row(children: [
        SizedBox(width: index % 2 == 0 ? 250 : 50),
        GestureDetector(
          onTap: () {
            if (index == currentlevel) {
              String tempLiter = (mainLiter * index).toStringAsFixed(1);

              double levelLiter = double.parse(tempLiter);
              int levelStep = (mainStep * index).toInt();
              int levelCalorie = (mainCalorie * index).toInt();

              context.read<HomeBloc>().add(LevelPressed(
                  Liter: levelLiter,
                  Step: levelStep,
                  Calories: levelCalorie,
                  ));
            }
          },
          child: Container(
            margin: EdgeInsets.all(10),
            height: 110,
            width: 110,
            decoration: BoxDecoration(
                boxShadow: [BoxShadow(offset: Offset(10, 10))],
                color: index > currentlevel
                    ? Colors.grey
                    : ThemeProvider.mainColor,
                borderRadius: BorderRadius.circular(20)),
            child: Center(
              child: Icon(
                index > currentlevel
                    ? Icons.lock
                    : (index == currentlevel ? Icons.favorite : Icons.check),
                size: 80,
                color: index > currentlevel
                    ? Colors.black
                    : ThemeProvider.secondColor,
              ),
            ),
          ),
        )
      ]);
    }

    return Scrollbar(
      radius: const Radius.circular(30),
      thickness: 10,
      thumbVisibility: true,
      controller: scrollController,
      child: SingleChildScrollView(
        controller: scrollController,
        child: Column(children: [
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: FaIcon(
              FontAwesomeIcons.trophy,
              color: Color.fromARGB(255, 239, 177, 52),
              size: 80,
            ),
          ),
          Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20), color: Colors.black),
            child: const Icon(
              Icons.arrow_upward_rounded,
              color: Colors.white,
              size: 40,
            ),
          ),
          for (int i = 7; i >= 1; i--) levelContainer(index: i)
        ]),
      ),
    );
  }
}
