import 'package:flutter/material.dart';

class WaveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final Path path = Path();
    // path.lineTo(0, size.height);
    double x = 0;
    const int numberOfWaves = 2;
    final double increment = size.width / numberOfWaves;
    bool startFromTop = false;

    while (x < size.width) {
      if (startFromTop) {
        path.cubicTo(x + increment / 2, 0, x + increment / 2, size.height,
            x + increment, size.height);
      } else {
        path.cubicTo(x + increment / 2, size.height, x + increment / 2, 0,
            x + increment, 0);
      }
      x += increment;
      startFromTop = !startFromTop;
    }

    path.lineTo(size.width, 0);
    path.lineTo(0, 0);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
