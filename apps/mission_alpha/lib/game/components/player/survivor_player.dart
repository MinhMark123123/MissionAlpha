import 'dart:async';
import 'dart:math';
import 'package:flame/components.dart';
import 'package:mission_alpha/game/components/base_component.dart';
import 'package:mission_alpha/game/components/objects/bullet_component.dart';
import 'package:mission_alpha/game/components/objects/invisible_barrel.dart';
import 'package:mission_alpha/game/components/player/player_state.dart';
import 'package:mission_alpha/game/game_helper/assets_survivor.dart';
import 'package:mission_alpha/global/game_size_const.dart';
import 'package:mobile_light/mobile_light.dart';
import 'package:flame/sprite.dart';

class SurvivorPlayer extends BaseSpriteAnimationGroup with Player {
  SurvivorPlayer({super.position})
      : super(
          size: Vector2.all(GameSizeConst.playerBodySizeRifle),
          anchor: Anchor.center,
        );
  final _playerDefaultAngle = Vector2(1, 0).screenAngle();

  final SpriteAnimProvider spriteAnimProvider = SpriteAnimProvider();

  late final SpawnComponent _bulletSpawner;
  late final InvisibleBarrel _invisibleBarrel;
  late final InvisibleBarrel _invisibleBarrel2;

  InvisibleBarrel get invisibleBarrel => _invisibleBarrel;

  InvisibleBarrel get invisibleBarrel2 => _invisibleBarrel2;

  @override
  bool get debugMode => false;

  @override
  ActorConfig get actorConfig => ActorConfig(
        moveSpeed: 1.12,
        horizontalControl: false,
        isTopDownRotate: true,
        defaultAngle: _playerDefaultAngle,
      );
  late PlayerState previousState;
  late double previousStepTime;

  @override
  FutureOr<void> onLoad() async {
    await super.onLoad();
    await spriteAnimProvider.initAnim();
    _setupAnimation();
    _invisibleBarrel = InvisibleBarrel(
      position: Vector2(
        size.x,
        size.y * 3 / 4 - GameSizeConst.bulletRadius / 2,
      ),
    );
    _invisibleBarrel2 = InvisibleBarrel(
      position: Vector2(
        size.x + 2,
        size.y * 3 / 4 - GameSizeConst.bulletRadius / 2,
      ),
    );

    _bulletSpawner = SpawnComponent(
      period: 0.15,
      autoStart: false,
      factory: (int amount) {
        return BulletComponent(
          size: Vector2.all(GameSizeConst.bulletRadius * 4),
          position: _invisibleBarrel.absolutePosition,
        );
      },
      selfPositioning: true,
    );
    add(_invisibleBarrel);
    add(_invisibleBarrel2);
    game.add(_bulletSpawner);
  }

  void _setupAnimation() {
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
    _addComplete(PlayerState.rifleMeleeAttack);
    _addComplete(PlayerState.handgunMeleeAttack);
    _addComplete(PlayerState.knifeMeleeAttack);
    _addComplete(PlayerState.flashMeleeAttack);
    current = PlayerState.rifleIdle;
  }

  void _addComplete(PlayerState state) {
    final ticket = getTicker(state);
    ticket.onComplete = () => _onCompleteSingleState(ticket);
  }

  SpriteAnimationTicker getTicker(PlayerState state) =>
      animationTickers![state]!;

  @override
  void update(double dt) {
    super.update(dt);
    doUpdate(game: game, component: this, dt: dt);
    _handleMoveAnim();
  }

  void _handleMoveAnim() {
    PlayerState currentState = current;
    final maxDelta = max(
      game.joyStick.delta.x.abs(),
      game.joyStick.delta.y.abs(),
    );
    if (maxDelta > 0 && !currentState.isAttack) {
      setToMove();
      if (maxDelta > 60) {
        animations![currentState]!.stepTime = SpriteAnimProvider.timeStepRun;
      } else {
        animations![currentState]!.stepTime = SpriteAnimProvider.timeStepMove;
      }
      return;
    }
    resetStepTime();
    if (currentState.isMoveState) {
      setToIdle();
    }
  }

  void meleeAttack() {
    resetStepTime();
    switch (current) {
      case PlayerState.rifleMove:
      case PlayerState.rifleShoot:
      case PlayerState.rifleReload:
      case PlayerState.rifleIdle:
        current = PlayerState.rifleMeleeAttack;
        break;
      case PlayerState.handgunMove:
      case PlayerState.handgunShoot:
      case PlayerState.handgunIdle:
      case PlayerState.handgunReload:
        current = PlayerState.handgunMeleeAttack;
        break;
      case PlayerState.knifeMove:
      case PlayerState.knifeIdle:
        current = PlayerState.knifeMeleeAttack;
        break;
      case PlayerState.flashMove:
      case PlayerState.flashIdle:
        current = PlayerState.flashMeleeAttack;
        break;
    }
  }

  void shoot() {
    switch (current) {
      case PlayerState.rifleMeleeAttack:
      case PlayerState.rifleMove:
      case PlayerState.rifleShoot:
      case PlayerState.rifleReload:
      case PlayerState.rifleIdle:
        current = PlayerState.rifleShoot;
        break;
      case PlayerState.handgunMeleeAttack:
      case PlayerState.handgunMove:
      case PlayerState.handgunShoot:
      case PlayerState.handgunIdle:
      case PlayerState.handgunReload:
        current = PlayerState.handgunShoot;
        break;
      default:
        break;
    }
    _bulletSpawner.timer.start();
  }

  void stopShooting() {
    _bulletSpawner.timer.stop();
    PlayerState currentState = current;
    if (currentState.isRifle) {
      current = PlayerState.rifleIdle;
    } else if (currentState.isHandGun) {
      current = PlayerState.handgunIdle;
    }
    resetStepTime();
    return;
  }

  void _onCompleteSingleState(SpriteAnimationTicker? ticker) {
    ticker?.reset();
    size = Vector2.all(GameSizeConst.playerBodySizeRifle);
    setToIdle();
  }

  void setToIdle() {
    PlayerState currentState = current;
    if (currentState.isRifle) {
      current = PlayerState.rifleIdle;
      return;
    }
    if (currentState.isHandGun) {
      current = PlayerState.handgunIdle;
      return;
    }
    if (currentState.isKnife) {
      current = PlayerState.knifeIdle;
      return;
    }
    if (currentState.isFlash) {
      current = PlayerState.flashIdle;
      return;
    }
  }

  void setToMove() {
    PlayerState currentState = current;
    if (currentState.isRifle) {
      current = PlayerState.rifleMove;
      return;
    }
    if (currentState.isHandGun) {
      current = PlayerState.handgunMove;
      return;
    }
    if (currentState.isKnife) {
      current = PlayerState.knifeMove;
      return;
    }
    if (currentState.isFlash) {
      current = PlayerState.flashMove;
      return;
    }
  }

  void updateState(PlayerState state) {
    previousState = current;
    current = state;
  }

  void resetStepTime() {
    PlayerState currentState = current;
    animations![currentState]!.stepTime = SpriteAnimProvider.timeStepMove;
  }
}
