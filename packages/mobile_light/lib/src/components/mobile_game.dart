import 'dart:async';

import 'package:flame/game.dart';
import 'package:flutter/foundation.dart';
import 'package:mobile_light/src/components/index.dart';

abstract class MobileGame extends FlameGame {
  late final GameJoystick _joyStick;

  GameJoystick get joyStick => _joyStick;

  GameJoystick provideJoystick();

  @mustCallSuper
  @override
  FutureOr<void> onLoad() async {
    _joyStick = provideJoystick();
    return super.onLoad();
  }
}
