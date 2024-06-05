import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:mission_alpha/game/components/base_component.dart';
import 'package:mission_alpha/game/components/objects/bullet_component.dart';
import 'package:mission_alpha/global/game_size_const.dart';

class InvisibleBarrel extends BaseCircleComponent {
  InvisibleBarrel({super.position})
      : super(
          paint: Paint()..color = Colors.red,
          radius: GameSizeConst.bulletRadius,
          anchor: Anchor.center,
        );

  @override
  bool get debugMode => false;
  late final SpawnComponent _bulletSpawner;

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    _bulletSpawner = SpawnComponent(
      period: 0.1,
      autoStart: false,
      factory: (int amount) {
        return BulletComponent(
          size: Vector2.all(GameSizeConst.bulletRadius * 4),
          position: Vector2(absolutePosition.x, absolutePosition.y),
        );
      },
      selfPositioning: true,
    );
    game.addToWorld(_bulletSpawner);
  }

  void shoot() {
    _bulletSpawner.timer.start();
  }

  void stopShooting() {
    _bulletSpawner.timer.stop();
  }
}
