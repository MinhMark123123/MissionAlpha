import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame/sprite.dart';
import 'package:mission_alpha/game/components/player/player_state.dart';
import 'package:mission_alpha/game/game_helper/assets_survivor.dart';
import 'package:mobile_light/mobile_light.dart';

class PlayerAnimation extends ComplexAnimationGroup {
  final SpriteAnimProvider spriteAnimProvider = SpriteAnimProvider();

  @override
  Future<void> initAnim() => spriteAnimProvider.initAnim();

  @override
  void setupAnimation({
    required SpriteAnimationGroupComponent groupComponent,
    required initialState,
  }) {
    groupComponent.animations = {
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
    addCompleteSingleState(
      animationTickers: groupComponent.animationTickers,
      state: PlayerState.rifleMeleeAttack,
    );
    addCompleteSingleState(
      animationTickers: groupComponent.animationTickers,
      state: PlayerState.handgunMeleeAttack,
    );
    addCompleteSingleState(
      animationTickers: groupComponent.animationTickers,
      state: PlayerState.knifeMeleeAttack,
    );
    addCompleteSingleState(
      animationTickers: groupComponent.animationTickers,
      state: PlayerState.flashMeleeAttack,
    );
    groupComponent.current = initialState;
  }
  @override
  void onCompleteSingleState(SpriteAnimationTicker ticker) {
    ticker.reset();
    super.onCompleteSingleState(ticker);
  }
}
