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

  @override
  FutureOr<void> onLoad() async {
    await super.onLoad();
    final pos1 = game.player.invisibleBarrel.absolutePosition;
    final pos2 = game.player.invisibleBarrel2.absolutePosition;
    final origin = pos2 - pos1;
    velocity = origin
      ..rotate(pos2.angleTo(pos1))
      ..scale(GameSpeedConst.speedBullet.toDouble());

    add(RectangleHitbox(collisionType: CollisionType.passive));
  }

  @override
  void update(double dt) {
    deltaPosition
      ..setFrom(velocity)
      ..scale(dt);
    position += deltaPosition;
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
      const Offset(0, GameSizeConst.bulletRadius + 2),
      GameSizeConst.bulletRadius,
      _paint,
    );
  }
}
