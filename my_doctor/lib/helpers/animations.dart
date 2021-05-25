import 'package:flutter/material.dart';

Route animationPage(Widget widget) {
  return PageRouteBuilder(
    transitionDuration: Duration(milliseconds: 400),
    pageBuilder: (BuildContext context, Animation<double> animation,
        Animation<double> secondaryAnimation) {
      return widget;
    },
    transitionsBuilder: (BuildContext context, Animation<double> animation,
        Animation<double> secondaryAnimation, Widget child) {
      return Align(
        child: FadeTransition(
          opacity: animation,
          child: child,
        ),
      );
    },
  );
}
