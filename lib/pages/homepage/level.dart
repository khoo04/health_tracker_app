import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:health_tracker_app/bloc/homepage/home_bloc.dart';
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
    ScrollController _scrollController = ScrollController();
    int currentlevel = 3;
    double mainLiter = 3000 / 7;
    double mainStep = 1000 / 7;
    double mainCalorie = 2300 / 7;

    Widget levelContainer({required int index}) {
      return Row(children: [
        SizedBox(width: index % 2 == 0 ? 250 : 50),
        GestureDetector(
          onTap: () {
            if (index == currentlevel) {
              String tempLiter = (mainLiter * index).toStringAsFixed(1);

              double levelLiter = double.parse(tempLiter);
              int levelStep = mainStep.toInt();
              int levelCalorie = mainCalorie.toInt();

              context.read<HomeBloc>().add(LevelPressed(
                  Liter: levelLiter,
                  Step: levelStep,
                  Calories: levelCalorie,
                  pageIndex: 1));
            }
          },
          child: Container(
            margin: EdgeInsets.all(10),
            height: 110,
            width: 110,
            decoration: BoxDecoration(
                color: index > currentlevel
                    ? Colors.grey
                    : Color.fromARGB(255, 20, 150, 126),
                borderRadius: BorderRadius.circular(20)),
            child: Center(
              child: Icon(
                index > currentlevel
                    ? Icons.lock
                    : (index == currentlevel ? Icons.favorite : Icons.check),
                size: 80,
                color: index > currentlevel
                    ? Colors.black
                    : Color.fromARGB(255, 226, 252, 214),
              ),
            ),
          ),
        )
      ]);
    }

    return Scrollbar(
      radius: Radius.circular(30),
      thickness: 10,
      thumbVisibility: true,
      controller: _scrollController,
      child: SingleChildScrollView(
        controller: _scrollController,
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
