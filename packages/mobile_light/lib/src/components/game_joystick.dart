import 'package:flame/components.dart';
import 'package:flutter/material.dart';

class GameJoystick extends JoystickComponent {
  final double knobSize;
  final double joySize;
  final Color knobColor;
  final Color joyBackground;
  final EdgeInsets? joyMargin;

  GameJoystick({
    this.knobSize = 30,
    this.joySize = 100,
    this.knobColor = Colors.white54,
    this.joyMargin,
    this.joyBackground = Colors.black38,
  }) : super(
          knob: CircleComponent(
            radius: knobSize,
            paint: Paint()..color = knobColor,
          ),
          margin: joyMargin ?? const EdgeInsets.only(left: 20, bottom: 20),
          background: CircleComponent(
            radius: joySize,
            paint: Paint()..color = joyBackground,
          ),
        );
}
