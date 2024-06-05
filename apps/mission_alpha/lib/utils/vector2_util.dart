import 'dart:math';

import 'package:flame/components.dart';

class Vector2Util {
  Vector2Util._();

  static Vector2 fromAngle(double angle) {
    // Calculate x and y components using cosine and sine
    final x = cos(angle * deg2Rad);
    final y = sin(angle * deg2Rad);
    return Vector2(x, y);
  }

  static double degreesToRads(num deg) {
    return (deg * pi) / 180.0;
  }

  static num get deg2Rad =>  (pi * 2) / 360;
}
