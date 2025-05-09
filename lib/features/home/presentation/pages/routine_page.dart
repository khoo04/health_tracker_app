import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:health_tracker_app/core/theme/app_pallete.dart';
import 'package:health_tracker_app/features/home/presentation/bloc/home_bloc.dart';
import 'package:health_tracker_app/features/home/presentation/widgets/routine_container.dart';
import 'package:pedometer/pedometer.dart';

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
  double currentLiter = 0;
  int currentStep = 0;
  int currentCalorie = 0;

  double percentLiter = 0, percentStep = 0, percentCalorie = 0;

  late Stream<StepCount> _stepCountStream;

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

  void _initPedometer() {
    _stepCountStream = Pedometer.stepCountStream;
    _stepCountStream.listen(
      _onStepCount,
    );
  }

  void _onStepCount(StepCount event) {
    setState(() {
      currentStep = event.steps;
      percentStep = ((currentStep / widget.goalSteps) * 100) * 0.01;
    });
  }

  Future<double?> addDialogBox(
      BuildContext context, Color color, IconData icon, String type) {
    return showDialog(
        context: context,
        builder: (context) {
          TextEditingController userInput = TextEditingController();

          void addValue(int value) {
            if (userInput.text.isEmpty) userInput.text = "0";
            
            double temp = double.parse(userInput.text);
            temp += value;
            userInput.text = temp.toStringAsFixed(1);
          }

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
                            SizedBox(
                              width: 200,
                              height: 50,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: TextField(
                                  controller: userInput,
                                  textAlign: TextAlign.center,
                                  keyboardType: TextInputType.number,
                                  decoration: const InputDecoration(
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
                                  onPressed: () => addValue(500),
                                  child: const Text("+500",
                                      style: TextStyle(
                                          fontSize: 20, color: Colors.black))),
                            ),
                            SizedBox(
                              width: 130,
                              child: ElevatedButton(
                                  onPressed: () => addValue(1000),
                                  child: const Text("+1000",
                                      style: TextStyle(
                                          fontSize: 20, color: Colors.black))),
                            )
                          ]),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                                onPressed: () => Navigator.pop(
                                    context, double.parse(userInput.text)),
                                child: const Icon(Icons.add,
                                    color: Colors.black))),
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
                    onTap: () async {
                      final temp = await addDialogBox(
                          context,
                          const Color.fromARGB(255, 52, 89, 191),
                          Icons.water_drop,
                          "ml");
                      if (temp == null || temp < 0) return;
                      
                      currentLiter += (temp / 1000);
                      calcuPercent();
                    },
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
                    onTap: () async {
                      final temp = await addDialogBox(
                          context,
                          const Color.fromARGB(255, 45, 179, 125),
                          Icons.fastfood_rounded,
                          "cl");
                      if (temp == null || temp < 0) return;
                      currentCalorie += temp.toInt();
                      calcuPercent();
                    },
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
                height: 120,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
