import 'package:flutter/material.dart';

import '../widgets/app_drawer.dart';
import '../widgets/bottom_bar.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('AI shifokor'),
        ),
        drawer: AppDrawer(),
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 25),
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.all(20),
                  child: Image.asset(
                    'assets/images/doctor.png',
                    width: 100,
                    height: 100,
                  ),
                ),
                const Text(
                  'AI shifokor',
                  style: TextStyle(fontSize: 20),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: const Text(
                    '\t\t\tAssalomu aleykum. Men sun\'iy aqlga ega shifokorman. Siz kiritgan ma\'lomotlar orqali Yurak kasalligi va Qandli diabetning ehtimollik ko\'rsatgichlarini bilib olasiz.',
                    style: TextStyle(fontSize: 18, fontFamily: 'KoHo'),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ),
        ),
        bottomNavigationBar: BottomBar(),
      ),
    );
  }
}
