import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:health_tracker_app/bloc/homepage/home_bloc.dart';
import 'package:health_tracker_app/main.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class RoutinePage extends StatefulWidget {
  const RoutinePage(
      {super.key,
      required this.goalLiters,
      required this.goalSteps,
      required this.goalCalories});
  final double goalLiters;
  final int goalSteps;
  final int goalCalories;

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
                                  child: Text("+500",
                                      style: TextStyle(fontSize: 20))),
                            ),
                            SizedBox(
                              width: 130,
                              child: ElevatedButton(
                                  onPressed: () {},
                                  child: Text("+1000",
                                      style: TextStyle(fontSize: 20))),
                            )
                          ]),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                                onPressed: () {}, child: Icon(Icons.add))),
                      )
                    ]),
              ),
            ),
          );
        });
  }

  Widget routineContainer(
      {required double left,
      required double right,
      required Color color1,
      required Color color2,
      required Color barColor,
      required IconData icon,
      required String type,
      required String addType,
      required String current,
      required String remain,
      required double percent}) {
    Color themeColor = Colors.white;
    return GestureDetector(
      onTap: () {
        if (type != "Step") {
          addDialogBox(context, barColor, icon, addType);
        }
      },
      child: Container(
        padding: EdgeInsets.fromLTRB(left, 10, right, 10),
        height: 150,
        width: 320,
        decoration: BoxDecoration(
            boxShadow: [BoxShadow(offset: Offset(5, 5), blurRadius: 10)],
            borderRadius: BorderRadius.circular(15),
            gradient: LinearGradient(colors: [color1, color2])),
        child: Column(children: [
          Row(children: [
            Icon(
              icon,
              size: 60,
              color: themeColor,
            ),
            Spacer(),
            Text(type,
                style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: themeColor))
          ]),
          Spacer(),
          Row(children: [
            SizedBox(width: 10),
            Text(current,
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: themeColor)),
            Spacer(),
            Text("$remain left",
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: themeColor)),
            SizedBox(width: 10)
          ]),
          LinearPercentIndicator(
            percent: percent,
            progressColor: barColor,
            lineHeight: 10,
            barRadius: Radius.circular(30),
          )
        ]),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          GestureDetector(
            onTap: () {
              context.read<HomeBloc>().add(BackPressed());
            },
            child: Container(
              margin: EdgeInsets.all(10),
              height: 30,
              width: 100,
              decoration: BoxDecoration(
                  color: ThemeProvider.mainColor,
                  borderRadius: BorderRadius.circular(10)),
              child: const Icon(
                Icons.keyboard_arrow_up,
                color: Colors.white,
                size: 30,
              ),
            ),
          ),
          Expanded(
              child: Stack(children: [
            Positioned(
              left: -20,
              child: routineContainer(
                  left: 25,
                  right: 20,
                  color1: Color.fromARGB(255, 153, 199, 242),
                  color2: Color.fromARGB(255, 0, 134, 187),
                  barColor: Color.fromARGB(255, 52, 89, 191),
                  icon: Icons.water_drop,
                  type: "Liter",
                  addType: " ml",
                  current: "$currentLiter",
                  remain:
                      "${(widget.goalLiters - currentLiter) < 0 ? 0 : (widget.goalLiters - currentLiter).toStringAsFixed(1)}",
                  percent: percentLiter > 1 ? 1 : percentLiter),
            ),
            Positioned(
              top: 160,
              right: -20,
              child: routineContainer(
                  left: 10,
                  right: 30,
                  color1: Color.fromARGB(255, 246, 165, 67),
                  color2: Color.fromARGB(255, 255, 47, 0),
                  barColor: Color.fromARGB(255, 188, 45, 33),
                  icon: Icons.directions_walk,
                  type: "Step",
                  addType: "",
                  current: "$currentStep",
                  remain:
                      "${(widget.goalSteps - currentStep) < 0 ? 0 : widget.goalSteps - currentStep}",
                  percent: percentStep > 1 ? 1 : percentStep),
            ),
            Positioned(
              left: -20,
              top: 320,
              child: routineContainer(
                  left: 25,
                  right: 20,
                  color1: Color.fromARGB(255, 148, 248, 165),
                  color2: Color.fromARGB(255, 3, 224, 110),
                  barColor: Color.fromARGB(255, 45, 179, 125),
                  icon: Icons.fastfood_rounded,
                  type: "Calorie",
                  addType: " cl",
                  current: "$currentCalorie",
                  remain:
                      "${(widget.goalCalories - currentCalorie) < 0 ? 0 : widget.goalCalories - currentCalorie}",
                  percent: percentCalorie > 1 ? 1 : percentCalorie),
            ),
          ]))
        ]),
      ),
    );
  }
}
