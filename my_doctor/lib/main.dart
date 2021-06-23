import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'screens/main_screen.dart';
import 'providers/dark_theme_provider.dart';
import 'helpers/styles.dart';
import 'screens/heart_diseases_list_screen.dart';
import 'screens/heart_disease_predict_screen.dart';
import 'screens/heart_disease_detail_screen.dart';
import 'providers/heart_disease_provider.dart';
import 'screens/diabetics_list_screen.dart';
import 'screens/diabetics_predict_screen.dart';
import 'screens/diabetics_detail_screen.dart';
import 'providers/diabetics_provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  DarkThemeProvider themeChangeProvider = DarkThemeProvider();

  @override
  void initState() {
    super.initState();
    getCurrentAppTheme();
  }

  Future<void> getCurrentAppTheme() async {
    themeChangeProvider.darkTheme =
        await themeChangeProvider.darkThemePreference.getTheme();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => themeChangeProvider),
        ChangeNotifierProvider(create: (_) => HeartDiseaseProvider()),
        ChangeNotifierProvider(create: (_) => DiabeticsProvider()),
      ],
      child: Consumer<DarkThemeProvider>(
        builder: (BuildContext context, value, Widget? child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'AI shifokor',
            theme: Styles.themeData(themeChangeProvider.darkTheme, context),
            home: MainScreen(),
            routes: {
              HeartDiseasesListScreen.routeName: (context) =>
                  HeartDiseasesListScreen(),
              HeartDiseaseDetailScreen.routeName: (context) =>
                  HeartDiseaseDetailScreen(),
              HeartDiseasePredictScreen.routeName: (context) =>
                  HeartDiseasePredictScreen(),
              DiabeticsListScreen.routeName: (context) => DiabeticsListScreen(),
              DiabeticsPredictScreen.routeName: (context) =>
                  DiabeticsPredictScreen(),
              DiabeticsDetailScreen.routeName: (context) =>
                  DiabeticsDetailScreen(),
            },
          );
        },
      ),
    );
  }
}
