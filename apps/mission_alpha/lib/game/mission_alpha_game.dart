import 'dart:async';
import 'dart:math';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:mission_alpha/game/components/objects/invisible_barrel.dart';
import 'package:mission_alpha/game/components/player/survivor_player.dart';
import 'package:mission_alpha/game/components/ui/melee_attack_button.dart';
import 'package:mission_alpha/game/components/ui/shoot_button.dart';
import 'package:mission_alpha/game/level/base_level.dart';
import 'package:mission_alpha/game/level/level_1.dart';
import 'package:mission_alpha/gen/assets.gen.dart';
import 'package:mission_alpha/global/game_size_const.dart';
import 'package:mission_alpha/utils/assets_gen_image_extension.dart';
import 'package:mobile_light/mobile_light.dart';

class MissionAlphaGame extends MobileGame with HasCollisionDetection {
  late SurvivorPlayer player;
  late BaseLevel currentLevel;

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
    await images.loadAll([
      Assets.images.shoot.gameImageName,
      Assets.images.meleeAttack.gameImageName,
    ]);
    await super.onLoad();
    camera.viewfinder.anchor = Anchor.center;
    camera.viewport.addAll([
      joyStick,
      MeleeAttackButton(this,
          position: Vector2(
            size.x - GameSizeConst.circleButtonSize - 16,
            size.y - GameSizeConst.circleButtonSize - 120,
          ),),
      ShootButton(this,
          position: Vector2(
            size.x - GameSizeConst.circleButtonSize - 16,
            size.y - GameSizeConst.circleButtonSize - 32,
          ),),
    ]);
    currentLevel = Level1();
    world.add(currentLevel);
  }

  void applyFollowCamera() {
    camera.follow(player);
  }
}
