import 'dart:async';
import 'dart:math';
import 'package:flame/components.dart';
import 'package:mission_alpha/game/game_helper/assets_survivor.dart';
import 'package:mission_alpha/game/survivor_game.dart';
import 'package:mission_alpha/global/game_size_const.dart';
import 'package:mobile_light/mobile_light.dart';

enum PlayerState {
  flashIdle,
  flashMeleeAttack,
  flashMove,
  handgunIdle,
  handgunMeleeAttack,
  handgunMove,
  handgunReload,
  handgunShoot,
  rifleIdle,
  rifleMeleeAttack,
  rifleMove,
  rifleReload,
  rifleShoot,
  knifeIdle,
  knifeMeleeAttack,
  knifeMove,
}

class SurvivorPlayer extends SpriteAnimationGroupComponent
    with Player, HasGameReference<SurvivorGame> {
  SurvivorPlayer({
    super.position,
  }) : super(
          size: Vector2.all(GameSizeConst.playerBodySize),
          anchor: Anchor.center,
        );
  final SpriteAnimProvider spriteAnimProvider = SpriteAnimProvider();

  @override
  bool get debugMode => true;

  @override
  ActorConfig get actorConfig => ActorConfig(
        moveSpeed: 1.5,
        horizontalControl: false,
        isTopDownRotate: true,
        defaultAngle: Vector2(1, 0).screenAngle(),
      );

  @override
  FutureOr<void> onLoad() async {
    await super.onLoad();
    await spriteAnimProvider.initAnim();
    animations = {
      PlayerState.flashIdle: spriteAnimProvider.flashIdleAnim,
      PlayerState.flashMove: spriteAnimProvider.flashMoveAnim,
      PlayerState.flashMeleeAttack: spriteAnimProvider.flashMeleeAttackAnim,
      PlayerState.handgunIdle: spriteAnimProvider.handgunIdleAnim,
      PlayerState.handgunMeleeAttack: spriteAnimProvider.handgunMeleeAttackAnim,
      PlayerState.handgunMove: spriteAnimProvider.handgunMoveAnim,
      PlayerState.handgunReload: spriteAnimProvider.handgunReloadAnim,
      PlayerState.handgunShoot: spriteAnimProvider.handgunShootAnim,
      PlayerState.rifleIdle: spriteAnimProvider.rifleIdleAnim,
      PlayerState.rifleMeleeAttack: spriteAnimProvider.rifleMeleeAttackAnim,
      PlayerState.rifleMove: spriteAnimProvider.rifleMoveAnim,
      PlayerState.rifleReload: spriteAnimProvider.rifleReloadAnim,
      PlayerState.rifleShoot: spriteAnimProvider.rifleShootAnim,
      PlayerState.knifeIdle: spriteAnimProvider.knifeIdleAnim,
      PlayerState.knifeMeleeAttack: spriteAnimProvider.knifeMeleeAttackAnim,
      PlayerState.knifeMove: spriteAnimProvider.knifeMoveAnim,
    };
    current = PlayerState.rifleMove;
  }

  @override
  void update(double dt) {
    super.update(dt);
    doUpdate(game: game, component: this, dt: dt);
    final velocity = max(game.joyStick.delta.x, game.joyStick.delta.y).abs();
  }
}
