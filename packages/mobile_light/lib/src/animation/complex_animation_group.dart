import 'package:flame/components.dart';
import 'package:flame/sprite.dart';
import 'package:flutter/foundation.dart';

abstract class ComplexAnimationGroup {
  Function? _onCompleteSingleStateAnim;
  set onCompleteSingleStateAnim(Function value) {
    _onCompleteSingleStateAnim = value;
  }

  Future<void> initAnim();
  void setupAnimation({
    required SpriteAnimationGroupComponent<dynamic> groupComponent,
    required dynamic initialState,
  });

  SpriteAnimationTicker? getTicker({
    Map<dynamic, SpriteAnimationTicker>? animationTickers,
    dynamic state,
  }) =>
      animationTickers?[state];

  void addCompleteSingleState({
    required Map<dynamic, SpriteAnimationTicker>? animationTickers,
    required dynamic state,
  }) {
    final ticker = getTicker(animationTickers: animationTickers, state: state);
    ticker?.onComplete = () => onCompleteSingleState(ticker);
  }

  @mustCallSuper
  void onCompleteSingleState(SpriteAnimationTicker ticker) {
    _onCompleteSingleStateAnim?.call();
  }
}
