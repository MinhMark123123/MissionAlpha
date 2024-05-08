import 'dart:async';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/extensions.dart';
import 'package:flutter/material.dart';
import 'package:mission_alpha/game/components/base_component.dart';
import 'package:mission_alpha/global/game_size_const.dart';
import 'package:mission_alpha/global/game_speed_const.dart';

class BulletComponent extends BasePositionComponent {
  BulletComponent({
    super.size,
    super.position,
    super.angle,
  }) : super(anchor: Anchor.center);
  late final Vector2 velocity;
  final Vector2 deltaPosition = Vector2.zero();
  static final _paint = Paint()..color = Colors.yellow;

  @override
  bool get debugMode => false;
 late  Vector2 pos2;
  @override
  FutureOr<void> onLoad() async {
    await super.onLoad();
    final pos1 = game.player.invisibleBarrel.absolutePosition;
     pos2 = game.player.invisibleBarrel2.absolutePosition;
    /*final camera = game.camera;
    final pos1 = camera.localToGlobal(game.player.invisibleBarrel.position);
    final pos2 = camera.localToGlobal(game.player.invisibleBarrel2.position);*/
    final origin = pos1 - pos2;
    print(pos1);
    print(pos2);
    print(origin);
    velocity = pos1
      ..rotate(pos2.angleTo(pos1))
      ..scale(GameSpeedConst.speedBullet.toDouble());
    add(RectangleHitbox());
  }

  @override
  void update(double dt) {
    deltaPosition
      ..setFrom(pos2)
      ..scale(dt);
    position += deltaPosition;
    /*deltaPosition
      ..setFrom(velocity)
      ..scale(dt);
    position += deltaPosition;*/
    print("bullet posiiotn : $absolutePosition");
    if (position.y * -1 >= game.size.y) removeFromParent();
    if (position.y >= game.size.y) removeFromParent();
    if (position.x < 0) removeFromParent();
    if (position.x > game.size.x) removeFromParent();
    super.update(dt);
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);
    canvas.drawCircle(
      const Offset(0, GameSizeConst.bulletRadius * 3 - 2),
      GameSizeConst.bulletRadius,
      _paint,
    );
  }
}
