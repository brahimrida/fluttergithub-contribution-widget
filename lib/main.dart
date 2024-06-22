// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_print, no_leading_underscores_for_local_identifiers

import 'dart:math';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        scaffoldBackgroundColor: Color.fromARGB(255, 34, 39, 46),
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: GitHubStats(data: _functionForRandomList()),
          ),
        ],
      ),
    );
  }
}

class GitHubStats extends StatefulWidget {
  const GitHubStats({super.key, required this.data});
  final List<List<Map>> data;

  @override
  State<GitHubStats> createState() => _GitHubStatsState();
}

class _GitHubStatsState extends State<GitHubStats> {
  Color? backColor = Color.fromARGB(255, 34, 39, 46);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Mon',
                  style: TextStyle(
                      color: const Color.fromARGB(255, 197, 209, 222),
                      fontSize: 12,
                      fontFamily: 'apple-system'),
                ),
                SizedBox(
                  height: 6,
                ),
                Text(
                  'Wed',
                  style: TextStyle(
                      color: const Color.fromARGB(255, 197, 209, 222),
                      fontSize: 12,
                      fontFamily: 'apple-system'),
                ),
                SizedBox(
                  height: 6,
                ),
                Text(
                  'Fri',
                  style: TextStyle(
                      color: const Color.fromARGB(255, 197, 209, 222),
                      fontSize: 12,
                      fontFamily: 'apple-system'),
                ),
              ],
            ),
            SizedBox(
              width: 4,
            ),
            ...List.generate(
              widget.data.length,
              (index) => pillar(
                widget.data[index],
                context,
              ),
            )
          ],
        ),
      ],
    );
  }
}

Widget pillar(
  List<Map> list,
  BuildContext context,
) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      ...List.generate(
        list.length,
        (index) => smallSquare(list[index]['number'], context),
      ),
    ],
  );
}

Widget smallSquare(int number, BuildContext context) {
  double width = MediaQuery.of(context).size.width;
  int dataMaxValue = 10;
  double calculation = (number / dataMaxValue) * 255;
  int degree = calculation.round();
  Color color = degree > 0
      ? Color.fromARGB(degree, 0, 255, 0)
      : Color.fromARGB(255, 22, 27, 34);

  return GestureDetector(
    onTap: () {
      OverlayEntry overlayEntry = OverlayEntry(
        builder: (context) => Center(
          child: Material(
            color: Colors.transparent,
            child: Container(
              width: 200,
              height: 30,
              color: Colors.blue,
              child: Center(
                child: Text(
                  'this is width: $width Number of contributions: $number',
                  style: TextStyle(color: Colors.white, fontSize: 11),
                ),
              ),
            ),
          ),
        ),
      );

      Overlay.of(context).insert(overlayEntry);

      // Close overlay after 2 seconds
      Future.delayed(const Duration(seconds: 2), () {
        overlayEntry.remove();
      });
    },
    child: Padding(
      padding: const EdgeInsets.all(1),
      child: Container(
        decoration:
            BoxDecoration(color: color, borderRadius: BorderRadius.circular(2)),
        height: width > 710 ? 11 : 7,
        width: width > 710 ? 11 : 7,
      ),
    ),
  );
}

class BubbleWidget extends StatelessWidget {
  const BubbleWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 50, width: 50, color: Colors.red, child: Text("hey"));
  }
}

List<List<Map>> _functionForRandomList() {
  const int weeks = 52;
  const int days = 7;

  List<List<Map>> list = [];
  for (int i = 0; i < weeks; i++) {
    List<Map<String, int>> nested = [];
    for (int j = 0; j < days; j++) {
      nested.add({'number': Random().nextInt(11)});
    }
    list.add(nested);
  }
  return list;
}
