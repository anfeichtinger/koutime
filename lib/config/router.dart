import 'package:flutter/material.dart';

import '../data/enums/animation_direction.dart';
import '../ui/screens/home_screen.dart';
import '../ui/screens/settings_screen.dart';

final Map<String, Widget Function(BuildContext)> routes =
    <String, Widget Function(BuildContext)>{
  '/': (BuildContext context) => const HomeScreen(),
  '/settings': (BuildContext context) => const SettingsScreen(),
};

Route<dynamic> createRoute(Widget target,
    {AnimationDirection direction = AnimationDirection.bottomToTop}) {
  return PageRouteBuilder<dynamic>(
    pageBuilder: (BuildContext context, Animation<double> animation,
            Animation<double> secondaryAnimation) =>
        target,
    transitionsBuilder: (BuildContext context, Animation<double> animation,
        Animation<double> secondaryAnimation, Widget child) {
      Offset begin;
      switch (direction) {
        case AnimationDirection.rightToLeft:
          begin = const Offset(1.0, 0.0);
          break;
        case AnimationDirection.bottomToTop:
          begin = const Offset(0.0, 1.0);
          break;
      }
      const Offset end = Offset.zero;
      const Cubic curve = Curves.ease;

      final Animatable<Offset> tween =
          Tween<Offset>(begin: begin, end: end).chain(CurveTween(curve: curve));

      return SlideTransition(
        position: animation.drive(tween),
        child: child,
      );
    },
  );
}
