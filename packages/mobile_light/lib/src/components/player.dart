import 'package:flame/components.dart';
import 'package:mobile_light/src/components/index.dart';

mixin class Player {
  ActorConfig get actorConfig => const ActorConfig();
  late final ActorController _actorController;

  ActorController get actorController => _actorController;

  void initActorController(PositionComponent component) {
    _actorController = ActorController(
      actorConfig: actorConfig,
      component: component,
    );
  }

  void doUpdate({
    required MobileGame game,
    required PositionComponent component,
    required double dt,
  }) {
    _actorController.applyControlWithJoystick(
      game: game,
      dt: dt,
    );
    onJoystickDelta(game.joyStick.delta, game.joyStick.direction);
  }

  void jump(bool jump) => _actorController.jump(jump);

  void onJoystickDelta(Vector2 delta, JoystickDirection direction) {}

  void addObstacleObject(PositionComponent object) {
    actorController.addObstacleObject(object);
  }

  void removeObstacleObject(PositionComponent object) {
    actorController.removeObstacleObject(object);
  }
}
