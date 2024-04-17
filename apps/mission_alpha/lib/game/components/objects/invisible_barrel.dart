import 'dart:ui';

import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:mission_alpha/game/components/base_component.dart';
import 'package:mission_alpha/global/game_size_const.dart';

class InvisibleBarrel extends BaseCircleComponent {
  InvisibleBarrel({super.position})
      : super(
          paint: Paint()..color = Colors.transparent,
          radius: GameSizeConst.bulletRadius,
          anchor: Anchor.center,
        );
}
