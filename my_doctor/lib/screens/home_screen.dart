import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/dark_theme_provider.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final themeChange =
        Provider.of<DarkThemeProvider>(context); // listen: false
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('AI shifokor'),
          centerTitle: true,
          actions: [
            IconButton(
              onPressed: () {
                themeChange.darkTheme = !themeChange.darkTheme;
              },
              icon: themeChange.darkTheme
                  ? const Icon(Icons.wb_sunny, color: Colors.white)
                  : const Icon(Icons.brightness_3, color: Colors.white),
              tooltip: themeChange.darkTheme ? 'Kunduzgi rejim' : 'Tungi rejim',
            ),
          ],
        ),
        body: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.all(20),
                  child: Image.asset(
                    'assets/images/doctor.png',
                    width: 120,
                    height: 120,
                  ),
                ),
                const Text(
                  'AI shifokor',
                  style: TextStyle(fontSize: 20),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    vertical: 20,
                    horizontal: 20,
                  ),
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
      ),
    );
  }
}
