import 'package:flutter/material.dart';

import '../helpers/animations.dart';
import '../screens/home_screen.dart';
import '../screens/heart_diseases_list_screen.dart';
import '../screens/diabetics_list_screen.dart';

class BottomBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: BottomAppBar(
        elevation: 30.0,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            IconButton(
              icon: const Icon(
                Icons.home,
                color: Colors.white,
              ),
              tooltip: 'Asosiy oyna',
              onPressed: () {
                Navigator.of(context)
                    .pushReplacement(animationPage(HomeScreen()));
              },
            ),
            IconButton(
              icon: const Icon(
                Icons.favorite,
                color: Colors.white,
              ),
              tooltip: 'Yurak kasalligi',
              onPressed: () {
                Navigator.of(context)
                    .pushReplacement(animationPage(HeartDiseasesListScreen()));
              },
            ),
            IconButton(
              icon: const Icon(
                Icons.biotech,
                color: Colors.white,
              ),
              tooltip: 'Qandli diabet',
              onPressed: () {
                Navigator.of(context)
                    .pushReplacement(animationPage(DiabeticsListScreen()));
              },
            ),
          ],
        ),
      ),
    );
  }
}
