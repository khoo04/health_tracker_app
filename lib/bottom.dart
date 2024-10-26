import 'package:flutter/material.dart';
import 'package:health_tracker_app/pages/article/article_home.dart';
import 'package:health_tracker_app/pages/homepage/level.dart';

import 'package:percent_indicator/linear_percent_indicator.dart';

class FramePage extends StatefulWidget {
  const FramePage({super.key});

  @override
  State<FramePage> createState() => _FramePageState();
}

class _FramePageState extends State<FramePage> {
  String username = "Shah";
  int level = 14;
  double currentPercent = ((10 / 300) * 100) * 0.01;

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
            color:
                index == currIndex ? Color.fromARGB(255, 20, 150, 126) : null,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> page = [const Bridge(), const ArticlePage()];

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        shadowColor: Colors.white,
        toolbarHeight: 70,
        automaticallyImplyLeading: false,
        title: Row(children: [
          const CircleAvatar(radius: 30, child: Icon(Icons.favorite, size: 35)),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      username,
                      style: TextStyle(fontSize: 17),
                    ),
                    Text(
                      "Lvl. $level",
                      style: TextStyle(fontSize: 15),
                    ),
                    LinearPercentIndicator(
                      barRadius: Radius.circular(10),
                      lineHeight: 15,
                      width: 150,
                      percent: currentPercent,
                      progressColor: Color.fromARGB(255, 20, 150, 126),
                    ),
                    const SizedBox(height: 5),
                    const Divider(thickness: 4, endIndent: 50)
                  ]),
            ),
          ),
        ]),
      ),
      body: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
        Expanded(
          child: IndexedStack(
            index: currIndex,
            children: page,
          ),
        ),
        Container(
          margin: EdgeInsets.only(bottom: 10),
          height: 80,
          width: 330,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(40),
              color: Color.fromARGB(255, 222, 225, 230)),
          child: Row(children: [
            bottomNaviIcon(icon: Icons.home, index: 0),
            bottomNaviIcon(icon: Icons.article, index: 1)
          ]),
        )
      ]),
    );
  }
}
