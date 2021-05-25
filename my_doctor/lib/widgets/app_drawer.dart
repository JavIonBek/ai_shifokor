import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../helpers/animations.dart';
import '../providers/dark_theme_provider.dart';
import '../screens/home_screen.dart';
import '../screens/heart_diseases_list_screen.dart';
import '../screens/diabetics_list_screen.dart';

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final themeChange =
        Provider.of<DarkThemeProvider>(context); // listen: false
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          Container(
            height: 150,
            child: DrawerHeader(
              child: Row(
                children: [
                  const CircleAvatar(
                    radius: 25,
                    backgroundImage:
                        const ExactAssetImage('assets/images/doctor.png'),
                  ),
                  Container(
                    padding: const EdgeInsets.only(left: 25),
                    child: const Text(
                      'AI shifokor',
                      style: TextStyle(fontSize: 20),
                    ),
                    alignment: Alignment.center,
                  ),
                ],
              ),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.home_outlined),
            title: const Text(
              'Asosiy oyna',
              style: TextStyle(fontSize: 16),
            ),
            onTap: () {
              // Navigator.of(context).pop();
              Navigator.of(context)
                  .pushReplacement(animationPage(HomeScreen()));
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.favorite_outline),
            title: const Text(
              'Yurak kasalligi',
              style: TextStyle(fontSize: 16),
            ),
            onTap: () {
              Navigator.of(context).pop();
              Navigator.of(context)
                  .pushReplacement(animationPage(HeartDiseasesListScreen()));
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.biotech_outlined),
            title: const Text(
              'Qandli diabet',
              style: TextStyle(fontSize: 16),
            ),
            onTap: () {
              Navigator.of(context).pop();
              Navigator.of(context)
                  .pushReplacement(animationPage(DiabeticsListScreen()));
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.bedtime_outlined),
            title: const Text(
              'Tungi rejim',
              style: TextStyle(fontSize: 16),
            ),
            trailing: Switch(
              value: themeChange.darkTheme,
              onChanged: (bool value) {
                themeChange.darkTheme = value;
              },
            ),
            onTap: () {
              Navigator.of(context).pop();
            },
          ),
          const SizedBox(height: 50),
        ],
      ),
    );
  }
}
