import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:health_tracker_app/core/theme/app_pallete.dart';
import 'package:health_tracker_app/features/home/presentation/bloc/home_bloc.dart';
import 'package:health_tracker_app/features/home/presentation/widgets/routine_container.dart';

class RoutinePage extends StatefulWidget {
  final double goalLiters;
  final int goalSteps;
  final int goalCalories;
  const RoutinePage({
    super.key,
    required this.goalLiters,
    required this.goalSteps,
    required this.goalCalories,
  });

  @override
  State<RoutinePage> createState() => _RoutinePageState();
}

class _RoutinePageState extends State<RoutinePage> {
  double currentLiter = 2.2;
  int currentStep = 500;
  int currentCalorie = 2300;

  double percentLiter = 0, percentStep = 0, percentCalorie = 0;

  void calcuPercent() {
    setState(() {
      percentLiter = ((currentLiter / widget.goalLiters) * 100) * 0.01;
      percentStep = ((currentStep / widget.goalSteps) * 100) * 0.01;
      percentCalorie = ((currentCalorie / widget.goalCalories) * 100) * 0.01;
    });
  }

  @override
  void initState() {
    super.initState();
    calcuPercent();
  }

  Future<void> addDialogBox(
      BuildContext context, Color color, IconData icon, String type) {
    return showDialog(
        context: context,
        builder: (context) {
          return Dialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            backgroundColor: color,
            child: SizedBox(
              height: 300,
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(icon, size: 80, color: Colors.white),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const SizedBox(
                              width: 200,
                              height: 50,
                              child: Padding(
                                padding: EdgeInsets.all(8.0),
                                child: TextField(
                                  textAlign: TextAlign.center,
                                  keyboardType: TextInputType.number,
                                  decoration: InputDecoration(
                                      contentPadding:
                                          EdgeInsets.only(bottom: 10),
                                      hintText: "200",
                                      hintStyle: TextStyle(
                                          color: Colors.grey, fontSize: 20),
                                      filled: true,
                                      fillColor: Colors.white,
                                      enabledBorder: OutlineInputBorder()),
                                ),
                              ),
                            ),
                            Text(
                              type,
                              style: const TextStyle(
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            )
                          ]),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            SizedBox(
                              width: 130,
                              child: ElevatedButton(
                                  onPressed: () {},
                                  child: const Text("+500",
                                      style: TextStyle(fontSize: 20))),
                            ),
                            SizedBox(
                              width: 130,
                              child: ElevatedButton(
                                  onPressed: () {},
                                  child: const Text("+1000",
                                      style: TextStyle(fontSize: 20))),
                            )
                          ]),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                                onPressed: () {},
                                child: const Icon(Icons.add))),
                      )
                    ]),
              ),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () {
                  context.read<HomeBloc>().add(BackPressed());
                },
                child: Container(
                  margin: const EdgeInsets.all(10),
                  height: 30,
                  width: 100,
                  decoration: BoxDecoration(
                      color: AppPallete.primaryColor,
                      borderRadius: BorderRadius.circular(10)),
                  child: const Icon(
                    Icons.keyboard_arrow_up,
                    color: Colors.white,
                    size: 30,
                  ),
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: RoutineContainer(
                    left: 25,
                    right: 20,
                    color1: const Color.fromARGB(255, 153, 199, 242),
                    color2: const Color.fromARGB(255, 0, 134, 187),
                    barColor: const Color.fromARGB(255, 52, 89, 191),
                    icon: Icons.water_drop,
                    type: "Liter",
                    addType: " ml",
                    current: "$currentLiter",
                    remain:
                        "${(widget.goalLiters - currentLiter) < 0 ? 0 : (widget.goalLiters - currentLiter).toStringAsFixed(1)}",
                    percent: percentLiter > 1 ? 1 : percentLiter),
              ),
              const SizedBox(
                height: 18,
              ),
              Align(
                alignment: Alignment.centerRight,
                child: RoutineContainer(
                    onTap: () {
                      addDialogBox(
                          context,
                          const Color.fromARGB(255, 188, 45, 33),
                          Icons.directions_walk,
                          "");
                    },
                    left: 10,
                    right: 30,
                    color1: const Color.fromARGB(255, 246, 165, 67),
                    color2: const Color.fromARGB(255, 255, 47, 0),
                    barColor: const Color.fromARGB(255, 188, 45, 33),
                    icon: Icons.directions_walk,
                    type: "Step",
                    addType: "",
                    current: "$currentStep",
                    remain:
                        "${(widget.goalSteps - currentStep) < 0 ? 0 : widget.goalSteps - currentStep}",
                    percent: percentStep > 1 ? 1 : percentStep),
              ),
              const SizedBox(
                height: 18,
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: RoutineContainer(
                    left: 25,
                    right: 20,
                    color1: const Color.fromARGB(255, 148, 248, 165),
                    color2: const Color.fromARGB(255, 3, 224, 110),
                    barColor: const Color.fromARGB(255, 45, 179, 125),
                    icon: Icons.fastfood_rounded,
                    type: "Calorie",
                    addType: " cl",
                    current: "$currentCalorie",
                    remain:
                        "${(widget.goalCalories - currentCalorie) < 0 ? 0 : widget.goalCalories - currentCalorie}",
                    percent: percentCalorie > 1 ? 1 : percentCalorie),
              ),
              const SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
