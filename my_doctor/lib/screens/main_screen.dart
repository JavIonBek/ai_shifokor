import 'package:flutter/material.dart';
import 'package:animations/animations.dart';

import 'home_screen.dart';
import 'heart_diseases_list_screen.dart';
import 'diabetics_list_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int pageIndex = 0;
  List<Widget> pageList = [
    HomeScreen(),
    HeartDiseasesListScreen(),
    DiabeticsListScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageTransitionSwitcher(
        transitionBuilder: (child, primaryAnimation, secondaryAnimation) =>
            FadeThroughTransition(
          animation: primaryAnimation,
          secondaryAnimation: secondaryAnimation,
          child: child,
        ),
        child: pageList[pageIndex],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: pageIndex,
        onTap: (value) {
          setState(() {
            pageIndex = value;
          });
        },
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
            icon: const Icon(Icons.home),
            label: 'Asosiy oyna',
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.favorite),
            label: 'Yurak kasalligi',
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.biotech),
            label: 'Qandli diabet',
          ),
        ],
      ),
    );
  }
}
