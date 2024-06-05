import 'dart:async';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';

class CollisionBlock extends PositionComponent {
  final bool isPlatform;

  CollisionBlock({
    required this.isPlatform,
    super.size,
    super.position,
    super.angle,
    super.nativeAngle,
    super.anchor,
  });

  @override
  FutureOr<void> onLoad() async {
    await super.onLoad();
    _initCollision();
  }

  void _initCollision() {
    if (isPlatform) {
      add(RectangleHitbox(collisionType: CollisionType.passive));
      return;
    }
    add(RectangleHitbox(collisionType: CollisionType.active));
  }
}
