import 'package:flame/components.dart';
import 'package:flame/input.dart';
import 'package:mission_alpha/game/mission_alpha_game.dart';

abstract class BaseSpriteAnimation extends SpriteAnimationComponent
    with HasGameReference<MissionAlphaGame> {
  BaseSpriteAnimation({
    super.animation,
    super.autoResize,
    super.removeOnFinish = false,
    super.playing = true,
    super.paint,
    super.position,
    super.size,
    super.scale,
    super.angle,
    super.nativeAngle,
    super.anchor,
    super.children,
    super.priority,
    super.key,
  });
}

abstract class BaseSpriteAnimationGroup extends SpriteAnimationGroupComponent
    with HasGameReference<MissionAlphaGame> {
  BaseSpriteAnimationGroup({
    super.animations,
    super.current,
    super.autoResize,
    super.playing = true,
    super.removeOnFinish = const {},
    super.autoResetTicker = true,
    super.paint,
    super.position,
    super.size,
    super.scale,
    super.angle,
    super.nativeAngle,
    super.anchor,
    super.children,
    super.priority,
    super.key,
  });
}

abstract class BaseSpriteComponent extends SpriteComponent
    with HasGameReference<MissionAlphaGame> {
  BaseSpriteComponent({
    super.sprite,
    super.autoResize,
    super.paint,
    super.position,
    super.size,
    super.scale,
    super.angle,
    super.nativeAngle,
    super.anchor,
    super.children,
    super.priority,
    super.key,
  });
}

abstract class BaseHudButtonComponent extends HudButtonComponent {
  BaseHudButtonComponent({
    super.button,
    super.buttonDown,
    super.margin,
    super.onPressed,
    super.onReleased,
    super.onCancelled,
    super.position,
    super.size,
    super.scale,
    super.angle,
    super.anchor,
    super.children,
    super.priority,
  });
}

abstract class BasePositionComponent extends PositionComponent
    with HasGameReference<MissionAlphaGame> {
  BasePositionComponent({
    super.position,
    super.size,
    super.scale,
    super.angle,
    super.nativeAngle = 0,
    super.anchor,
    super.children,
    super.priority,
    super.key,
  });
}

abstract class BaseCircleComponent extends CircleComponent
    with HasGameReference<MissionAlphaGame> {
  BaseCircleComponent({
    super.radius,
    super.position,
    super.scale,
    super.angle,
    super.anchor,
    super.children,
    super.priority,
    super.paint,
    super.paintLayers,
  });
}
