import 'package:flutter/material.dart';

class Styles {
  static ThemeData themeData(bool isDarkTheme, BuildContext context) {
    if (isDarkTheme) {
      return ThemeData(
        fontFamily: 'KoHo-Medium',
        primarySwatch: Colors.teal,
        primaryColor: Colors.teal,
        backgroundColor: const Color(0xFF212121),
        indicatorColor: const Color(0xff0E1D36),
        buttonColor: const Color(0xff3B3B3B),
        hintColor: Colors.white70,
        highlightColor: const Color(0xff372901),
        hoverColor: const Color(0xff3A3A3B),
        focusColor: const Color(0xff0B2512),
        disabledColor: Colors.grey,
        textSelectionTheme:
            const TextSelectionThemeData(selectionColor: Colors.white),
        brightness: Brightness.dark,
        buttonTheme: Theme.of(context)
            .buttonTheme
            .copyWith(colorScheme: const ColorScheme.dark()),
        floatingActionButtonTheme:
            FloatingActionButtonThemeData(backgroundColor: Colors.teal),
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          backgroundColor: Colors.teal,
          selectedItemColor: Colors.white,
        ),
      );
    } else {
      return ThemeData(
        fontFamily: 'KoHo-Medium',
        primarySwatch: Colors.blue,
        primaryColor: Colors.blue,
        backgroundColor: const Color(0xFFE5E5E5), // 0xffF1F5FB
        indicatorColor: const Color(0xffCBDCF8),
        buttonColor: const Color(0xffF1F5FB),
        hintColor: Colors.black54,
        highlightColor: const Color(0xffFCE192),
        hoverColor: const Color(0xff4285F4),
        focusColor: const Color(0xffA8DAB5),
        disabledColor: Colors.grey,
        textSelectionTheme:
            const TextSelectionThemeData(selectionColor: Colors.black),
        brightness: Brightness.light,
        buttonTheme: Theme.of(context)
            .buttonTheme
            .copyWith(colorScheme: const ColorScheme.light()),
        floatingActionButtonTheme:
            FloatingActionButtonThemeData(backgroundColor: Colors.blue),
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          backgroundColor: Colors.blue,
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.white.withOpacity(0.7),
        ),
      );
    }
  }
}
