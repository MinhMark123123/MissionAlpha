import 'dart:async';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/sprite.dart';
import 'package:mission_alpha/game/components/base_component.dart';
import 'package:mission_alpha/game/components/enemies/zombie_state.dart';
import 'package:mission_alpha/game/components/objects/bullet_component.dart';
import 'package:mission_alpha/game/game_helper/assets_zombie.dart';
import 'package:mission_alpha/global/game_size_const.dart';

class ZombieEnemy extends BaseSpriteAnimationGroup with CollisionCallbacks {
  ZombieEnemy({super.position})
      : super(
            size: Vector2.all(GameSizeConst.playerBodySizeRifle),
            anchor: Anchor.center);
  final EnemyAnimProvider spriteAnimProvider = EnemyAnimProvider();

  @override
  bool get debugMode => false;

  @override
  FutureOr<void> onLoad() async {
    await super.onLoad();
    await spriteAnimProvider.initAnim();
    animations = {
      ZombieState.idle: spriteAnimProvider.zombieIdle,
      ZombieState.move: spriteAnimProvider.zombieMove,
      ZombieState.attack: spriteAnimProvider.zombieAttack,
    };
    current = ZombieState.idle;
    _addComplete(ZombieState.attack);
    add(
      RectangleHitbox(
        size: Vector2(size.x - 20, size.y - 20),
        anchor: Anchor.center,
        position: Vector2(size.x/2,size.y /2),
      ),
    );
  }

  @override
  void update(double dt) {
    super.update(dt);
    // lookAt(game.player.position);
  }

  void _addComplete(ZombieState state) {
    final ticket = getTicker(state);
    ticket.onComplete = () => _onCompleteSingleState(ticket);
  }

  SpriteAnimationTicker getTicker(ZombieState state) =>
      animationTickers![state]!;

  void _onCompleteSingleState(SpriteAnimationTicker ticket) {
    ticket.reset();
    current = ZombieState.idle;
  }

  @override
  void onCollisionStart(
    Set<Vector2> intersectionPoints,
    PositionComponent other,
  ) {
    super.onCollisionStart(intersectionPoints, other);
    if (other is BulletComponent) {
      other.removeFromParent();
    }
  }
}
