import 'dart:async';
import 'dart:math';

import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:mission_alpha/game/components/survivor_player.dart';
import 'package:mobile_light/mobile_light.dart';

class SurvivorGame extends MobileGame {
  @override
  Color backgroundColor() {
    return Colors.grey;
  }

  @override
  GameJoystick provideJoystick() {
    final minSize = min(size.x, size.y);
    final joySize = minSize / 5;
    final knobSize = joySize / 3;
    return GameJoystick(joySize: joySize, knobSize: knobSize);
  }

  @override
  FutureOr<void> onLoad() async {
    await super.onLoad();
    camera.viewfinder.anchor = Anchor.topLeft;
    camera.viewport.addAll([joyStick]);
    world.add(
      SurvivorPlayer(position: Vector2(size.x / 2, size.y / 2)),
    );
  }
}
