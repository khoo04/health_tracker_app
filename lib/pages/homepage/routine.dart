import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:health_tracker_app/bloc/homepage/home_bloc.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class RoutinePage extends StatelessWidget {
  const RoutinePage(
      {super.key,
      required this.goalLiters,
      required this.goalSteps,
      required this.goalCalories});
  final double goalLiters;
  final int goalSteps;
  final int goalCalories;

  @override
  Widget build(BuildContext context) {
    double currentLiter = 0;
    int currentStep = 0;
    int currentCalorie = 0;

    Future<void> addDialogBox(
        BuildContext context, Color color, IconData icon, String type) {
      return showDialog(
          context: context,
          builder: (context) {
            return Dialog(
              child: Container(
                padding: EdgeInsets.all(10),
                height: 300,
                width: 200,
                decoration: BoxDecoration(
                    color: color, borderRadius: BorderRadius.circular(30)),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(icon, size: 80),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const SizedBox(
                              width: 200,
                              child: Padding(
                                padding: EdgeInsets.all(8.0),
                                child: TextField(
                                  textAlign: TextAlign.center,
                                  keyboardType: TextInputType.number,
                                  decoration: InputDecoration(
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
                                  fontSize: 30, fontWeight: FontWeight.bold),
                            )
                          ]),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            ElevatedButton(
                                onPressed: () {}, child: Text("+500")),
                            ElevatedButton(
                                onPressed: () {}, child: Text("+1000"))
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
        required String remain}) {
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
              borderRadius: BorderRadius.circular(15),
              gradient: LinearGradient(colors: [color1, color2])),
          child: Column(children: [
            Row(children: [
              Icon(icon, size: 60),
              Spacer(),
              Text(type,
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold))
            ]),
            Spacer(),
            Row(children: [
              SizedBox(width: 10),
              Text(current,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              Spacer(),
              Text("$remain left",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              SizedBox(width: 10)
            ]),
            LinearPercentIndicator(
              progressColor: barColor,
              lineHeight: 10,
              barRadius: Radius.circular(30),
            )
          ]),
        ),
      );
    }

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
                  color: Colors.amber, borderRadius: BorderRadius.circular(10)),
              child: const Icon(
                Icons.keyboard_arrow_up,
                color: Colors.white,
                size: 30,
              ),
            ),
          ),
          Expanded(
              child: Container(
            child: Stack(children: [
              Positioned(
                left: -20,
                child: routineContainer(
                    left: 25,
                    right: 20,
                    color1: Color.fromARGB(255, 153, 199, 242),
                    color2: Color.fromARGB(255, 52, 89, 191),
                    barColor: Color.fromARGB(255, 9, 93, 126),
                    icon: Icons.water_drop,
                    type: "Liter",
                    addType: " ml",
                    current: "$currentLiter",
                    remain: "${goalLiters - currentLiter}"),
              ),
              Positioned(
                top: 160,
                right: -20,
                child: routineContainer(
                    left: 10,
                    right: 30,
                    color1: Color.fromARGB(255, 255, 151, 24),
                    color2: Color.fromARGB(255, 255, 57, 39),
                    barColor: Color.fromARGB(255, 232, 80, 46),
                    icon: Icons.directions_walk,
                    type: "Step",
                    addType: "",
                    current: "$currentStep",
                    remain: "${goalSteps - currentStep}"),
              ),
              Positioned(
                left: -20,
                top: 320,
                child: routineContainer(
                    left: 25,
                    right: 20,
                    color1: Color.fromARGB(255, 148, 248, 165),
                    color2: Color.fromARGB(255, 26, 217, 141),
                    barColor: Color.fromARGB(255, 76, 196, 134),
                    icon: Icons.fastfood_rounded,
                    type: "Calorie",
                    addType: " cl",
                    current: "$currentCalorie",
                    remain: "${goalCalories - currentCalorie}"),
              ),
            ]),
          ))
        ]),
      ),
    );
  }
}
