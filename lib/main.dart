// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_print

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
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
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
            child: GitHubStats(
              dataList: [
                [
                  {'number': 4},
                  {'number': 0},
                  {'number': 2},
                  {'number': 5},
                  {'number': 0},
                  {'number': 10},
                  {'number': 6},
                  {'number': 0},
                ],
                [
                  {'number': 8},
                  {'number': 0},
                  {'number': 2},
                  {'number': 10},
                  {'number': 0},
                  {'number': 5},
                  {'number': 6},
                  {'number': 9},
                ]
              ],
            ),
          )
        ],
      ),
    );
  }
}

class GitHubStats extends StatefulWidget {
  const GitHubStats({super.key, required this.dataList});
  final List<List<Map>> dataList;

  @override
  State<GitHubStats> createState() => _GitHubStatsState();
}

class _GitHubStatsState extends State<GitHubStats> {
  Color? backColor = Color.fromARGB(255, 34, 39, 46);
  bool white = false;
  // final LayerLink _layerLink = LayerLink();
  // OverlayEntry? _overlayEntry;

  // void _showOverlay(BuildContext context) {
  //   OverlayState overlayState = Overlay.of(context);
  //   _overlayEntry = OverlayEntry(
  //     builder: (context) => Positioned(
  //       width: 100,
  //       child: CompositedTransformFollower(
  //         link: _layerLink,
  //         showWhenUnlinked: false,
  //         offset: Offset(0.0, 50.0),
  //         child: Material(
  //           color: Colors.transparent,
  //           child: BubbleWidget(),
  //         ),
  //       ),
  //     ),
  //   );

  //   overlayState.insert(_overlayEntry!);
  // }

  // void _hideOverlay() {
  //   _overlayEntry?.remove();
  //   // _overlayEntry = null;
  // }

  void changeBackgroundColor() {
    setState(() {
      if (!white) {
        backColor = Colors.white;
        white = true;
      } else {
        backColor = Colors.grey[850];
        white = false;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height * 0.2;
    double width = MediaQuery.of(context).size.width * 0.7;
    return Container(
      decoration: BoxDecoration(
        color: backColor,
        borderRadius: BorderRadius.circular(
          12,
        ),
      ),
      height: height,
      width: width,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ...List.generate(
            widget.dataList.length,
            (index) => pillar(
              widget.dataList[index],
              context,
              changeBackgroundColor,
            ),
          )
        ],
      ),
    );
  }
}

Widget pillar(List<Map> list, BuildContext context, Function changebgColor) {
  return Column(
    children: [
      ...List.generate(
        list.length,
        (index) => smallSquare(list[index]['number'], context, changebgColor),
      ),
    ],
  );
}

Widget smallSquare(int number, BuildContext context, Function changebgColor) {
  double calculation = (1 - number / 10) * 255;
  int degree = calculation.round();
  print("the degree: $degree");
  Color color = degree > 0
      ? Color.fromARGB(degree, 0, 255, 0)
      : Color.fromARGB(255, 22, 27, 34);

  return GestureDetector(
    onTap: () {
      changebgColor();
      print('click');
    },
    child: Padding(
      padding: const EdgeInsets.all(1),
      child: Container(
        decoration:
            BoxDecoration(color: color, borderRadius: BorderRadius.circular(2)),
        height: 10,
        width: 10,
      ),
    ),
  );
}

class BubbleWidget extends StatelessWidget {
  const BubbleWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
