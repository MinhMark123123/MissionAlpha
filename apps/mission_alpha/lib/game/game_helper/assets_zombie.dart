import 'package:flame/components.dart';

class AssetsZombie {
  AssetsZombie._();

  static const basePath = "enemy";
  static const basePathZom = "$basePath/zom";
  static final zomIdle = List<String>.generate(
    17,
        (index) => "$basePathZom/idle/skeleton-idle_${index + 1}.png",
  );
  static final zomMove = List<String>.generate(
    17,
        (index) => "$basePathZom/move/skeleton-move_${index + 1}.png",
  );
  static final zomAttack = List<String>.generate(
    9,
        (index) => "$basePathZom/attack/skeleton-attack_$index.png",
  );
}

class EnemyAnimProvider {
  static final EnemyAnimProvider _instance = EnemyAnimProvider._();

  static const double timeStepIdle = 0.1;
  static const double timeStepMeleeAttack = 0.1;
  static const double timeStepMove = 0.1;

  EnemyAnimProvider._();

  late SpriteAnimation zombieIdle;
  late SpriteAnimation zombieMove;
  late SpriteAnimation zombieAttack;

  factory EnemyAnimProvider() {
    return _instance;
  }

  Future<void> initAnim() async {
    final idle = await Future.wait(
      AssetsZombie.zomIdle
          .map((e) => Sprite.load(e, srcSize: Vector2(318, 294))),
    );
    final move = await Future.wait(
      AssetsZombie.zomMove
          .map((e) => Sprite.load(e, srcSize: Vector2(318, 294))),
    );

    final attack = await Future.wait(
      AssetsZombie.zomAttack
          .map((e) => Sprite.load(e, srcSize: Vector2(318, 294))),
    );
    zombieIdle = SpriteAnimation.spriteList(
      idle,
      stepTime: timeStepIdle,
    );
    zombieMove = SpriteAnimation.spriteList(
      move,
      stepTime: timeStepMove,
    );
    zombieAttack = SpriteAnimation.spriteList(
      attack,
      stepTime: timeStepMeleeAttack,
      loop: false,
    );
  }
}
