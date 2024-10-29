import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:health_tracker_app/core/theme/app_pallete.dart';
import 'package:health_tracker_app/features/home/presentation/bloc/home_bloc.dart';

class LevelPage extends StatelessWidget {
  const LevelPage({super.key});

  @override
  Widget build(BuildContext context) {
    ScrollController scrollController = ScrollController();

    int currentlevel = 3;
    double mainLiter = 3 / 7;
    double mainStep = 2500 / 7;
    double mainCalorie = 3000 / 7;

    return Scrollbar(
      radius: const Radius.circular(30),
      thickness: 10,
      thumbVisibility: true,
      controller: scrollController,
      child: SingleChildScrollView(
        padding: const EdgeInsets.only(bottom: 100),
        controller: scrollController,
        child: Column(
          children: [
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
            for (int i = 7; i >= 1; i--)
              Padding(
                padding: EdgeInsets.only(
                  left: i % 2 == 1 ? 150.0 : 0.0,
                  right: i % 2 == 0 ? 150.0 : 0.0,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    levelContainer(
                      context,
                      index: i,
                      currentlevel: currentlevel,
                      mainLiter: mainLiter,
                      mainStep: mainStep,
                      mainCalorie: mainCalorie,
                    ),
                  ],
                ),
              )
          ],
        ),
      ),
    );
  }

  Widget levelContainer(
    BuildContext context, {
    required int index,
    required int currentlevel,
    required double mainLiter,
    required double mainStep,
    required double mainCalorie,
  }) {
    return GestureDetector(
      onTap: () {
        if (index == currentlevel) {
          String tempLiter = (mainLiter * index).toStringAsFixed(1);

          double levelLiter = double.parse(tempLiter);
          int levelStep = (mainStep * index).toInt();
          int levelCalorie = (mainCalorie * index).toInt();

          context.read<HomeBloc>().add(LevelPressed(
                liter: levelLiter,
                step: levelStep,
                calories: levelCalorie,
              ));
        }
      },
      child: Container(
        margin: const EdgeInsets.all(10),
        height: 110,
        width: 110,
        decoration: BoxDecoration(
            boxShadow: const [BoxShadow(offset: Offset(10, 10))],
            color: index > currentlevel ? Colors.grey : AppPallete.primaryColor,
            borderRadius: BorderRadius.circular(20)),
        child: Center(
          child: Icon(
            index > currentlevel
                ? Icons.lock
                : (index == currentlevel ? Icons.favorite : Icons.check),
            size: 80,
            color:
                index > currentlevel ? Colors.black : AppPallete.secondaryColor,
          ),
        ),
      ),
    );
  }
}
