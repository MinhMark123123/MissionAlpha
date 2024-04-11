import 'package:flame/components.dart';
import 'package:mobile_light/src/components/index.dart';

mixin class Player {
  ActorConfig get actorConfig => const ActorConfig();
  late final ActorController _actorController = ActorController(
    actorConfig: actorConfig,
  );
  ActorController get actorController => _actorController;

  void doUpdate({
    required MobileGame game,
    required PositionComponent component,
    required double dt,
  }) {
    _actorController.applyControlWithJoystick(
      game: game,
      component: component,
      dt: dt,
    );
    onJoystickDelta(game.joyStick.delta, game.joyStick.direction);
  }
  void jump(bool jump) => _actorController.jump(jump);

  void onJoystickDelta(Vector2 delta, JoystickDirection direction) {}
}
