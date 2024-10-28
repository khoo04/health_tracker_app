import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class RoutineContainer extends StatelessWidget {
  final double left;
  final double right;
  final Color color1;
  final Color color2;
  final Color barColor;
  final IconData icon;
  final String type;
  final String addType;
  final String current;
  final String remain;
  final double percent;
  final void Function()? onTap;

  const RoutineContainer(
      {super.key,
      required this.left,
      required this.right,
      required this.color1,
      required this.color2,
      required this.barColor,
      required this.icon,
      required this.type,
      required this.addType,
      required this.current,
      required this.remain,
      required this.percent,
      this.onTap});

  @override
  Widget build(BuildContext context) {
    Color themeColor = Colors.white;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.fromLTRB(left, 10, right, 10),
        height: 150,
        width: 320,
        decoration: BoxDecoration(
            boxShadow: const [BoxShadow(offset: Offset(5, 5), blurRadius: 10)],
            borderRadius: BorderRadius.circular(15),
            gradient: LinearGradient(colors: [color1, color2])),
        child: Column(children: [
          Row(children: [
            Icon(
              icon,
              size: 60,
              color: themeColor,
            ),
            const Spacer(),
            Text(type,
                style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: themeColor))
          ]),
          const Spacer(),
          Row(children: [
            const SizedBox(width: 10),
            Text(current,
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: themeColor)),
            const Spacer(),
            Text("$remain left",
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: themeColor)),
            const SizedBox(width: 10)
          ]),
          LinearPercentIndicator(
            percent: percent,
            progressColor: barColor,
            lineHeight: 10,
            barRadius: const Radius.circular(30),
          )
        ]),
      ),
    );
  }
}
