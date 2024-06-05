import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flutter/services.dart';
import 'package:mobile_light/src/components/index.dart';
import 'package:mobile_light/src/support/platform_collision_supporter.dart';

class ActorConfig {
  const ActorConfig({
    this.moveSpeed = 200,
    this.gravity = 10,
    this.jumpSpeed = 600,
    this.terminalVelocity = 150,
    this.horizontalControl = true,
    this.blockedGameSize = false,
    this.isTopDownRotate = false,
    this.defaultAngle = 0,
  });

  final double moveSpeed;
  final double gravity;
  final double jumpSpeed;
  final double terminalVelocity;
  final bool horizontalControl;
  final bool blockedGameSize;
  final bool isTopDownRotate;
  final double defaultAngle;
}

class ActorController {
  ActorController({required this.actorConfig, required this.component}) {
    _init();
  }

  final PositionComponent component;
  final ActorConfig actorConfig;
  final Vector2 velocity = Vector2.zero();
  bool hasJumped = false;
  int horizontalDirection = 0;
  bool isOnGround = false;
  double latestAngle = Vector2.zero().screenAngle();
  late final PlatformCollisionSupporter _collisionSupporter;

  void _init() {
    _collisionSupporter = PlatformCollisionSupporter(component: component);
  }

  void onKeyEvent(KeyEvent event, Set<LogicalKeyboardKey> keysPressed) {
    horizontalDirection = 0;
    horizontalDirection += _isLeftSideKey(keysPressed) ? -1 : 0;
    horizontalDirection += _isRightSideKey(keysPressed) ? 1 : 0;
    hasJumped = keysPressed.contains(LogicalKeyboardKey.space);
  }

  bool _isLeftSideKey(Set<LogicalKeyboardKey> keysPressed) {
    return keysPressed.contains(LogicalKeyboardKey.keyA) ||
        keysPressed.contains(LogicalKeyboardKey.arrowLeft);
  }

  bool _isRightSideKey(Set<LogicalKeyboardKey> keysPressed) {
    return keysPressed.contains(LogicalKeyboardKey.keyD) ||
        keysPressed.contains(LogicalKeyboardKey.arrowRight);
  }

  void applyKeyboardUpdate(double dt) {
    velocity.x = horizontalDirection * actorConfig.moveSpeed;
    component.position += velocity * dt;
    if (horizontalDirection < 0 && component.scale.x > 0) {
      component.flipHorizontally();
      return;
    }
    if (horizontalDirection > 0 && component.scale.x < 0) {
      component.flipHorizontally();
      return;
    }
    _handleJump();
  }

  void _handleJump() {
    velocity.y += actorConfig.gravity;
    if (hasJumped) {
      if (isOnGround) {
        velocity.y = -actorConfig.jumpSpeed;
        isOnGround = false;
      }
      hasJumped = false;
    }
    velocity.y = velocity.y.clamp(
      -actorConfig.jumpSpeed,
      actorConfig.terminalVelocity,
    );
  }

  void applyControlWithJoystick({
    required MobileGame game,
    required double dt,
  }) {
    final joystick = game.joyStick;
    if (actorConfig.horizontalControl) {
      _handleHorizontalMoving(
        joystick: joystick,
        game: game,
        dt: dt,
      );
      return;
    }
    _handleMoving(
      joystick: joystick,
      game: game,
      dt: dt,
    );
  }

  void _handleHorizontalMoving({
    required GameJoystick joystick,
    required MobileGame game,
    required double dt,
  }) {
    horizontalDirection = 0;
    var isLeftSide = false;
    var isRightSide = false;
    final position = component.position;
    switch (joystick.direction) {
      case JoystickDirection.up:
      case JoystickDirection.down:
      case JoystickDirection.upLeft:
      case JoystickDirection.downLeft:
      case JoystickDirection.left:
        _joyStickMoveLeft(position, game, joystick, dt);
        isLeftSide = true;
        isRightSide = false;
        break;
      case JoystickDirection.upRight:
      case JoystickDirection.downRight:
      case JoystickDirection.right:
        _joyStickMoveRight(position, game, joystick, dt);
        isRightSide = true;
        isLeftSide = false;
        break;
      case JoystickDirection.idle:
        break;
    }
    horizontalDirection += isLeftSide ? -1 : 0;
    horizontalDirection += isRightSide ? 1 : 0;
    if (horizontalDirection < 0 && component.scale.x > 0) {
      component.flipHorizontally();
      return;
    }
    if (horizontalDirection > 0 && component.scale.x < 0) {
      component.flipHorizontally();
      return;
    }
    _handleJump();
  }

  void _joyStickMoveRight(
    NotifyingVector2 position,
    MobileGame game,
    GameJoystick joystick,
    double dt,
  ) {
    if (actorConfig.blockedGameSize) {
      if (position.x < game.size.x) {
        position.x += actorConfig.moveSpeed * joystick.delta.x * dt;
      }
    } else {
      position.x += actorConfig.moveSpeed * joystick.delta.x * dt;
    }
  }

  void _joyStickMoveLeft(
    NotifyingVector2 position,
    MobileGame game,
    GameJoystick joystick,
    double dt,
  ) {
    if (actorConfig.blockedGameSize) {
      if (position.x > 0) {
        position.x += actorConfig.moveSpeed * joystick.delta.x * dt;
      }
    } else {
      position.x += actorConfig.moveSpeed * joystick.delta.x * dt;
    }
  }

  void _handleMoving({
    required GameJoystick joystick,
    required MobileGame game,
    required double dt,
  }) {
    horizontalDirection = 0;
    var isLeftSide = false;
    var isRightSide = false;
    final position = component.position;
    switch (joystick.direction) {
      case JoystickDirection.up:
        _joyStickMoveUp(position, joystick, dt);
        break;
      case JoystickDirection.down:
        _joyStickMoveDown(position, game, joystick, dt);
        break;
      case JoystickDirection.upLeft:
        _joyStickMoveUp(position, joystick, dt);
        _joyStickMoveLeft(position, game, joystick, dt);
        isLeftSide = true;
        isRightSide = false;
        break;
      case JoystickDirection.downLeft:
        _joyStickMoveDown(position, game, joystick, dt);
        _joyStickMoveLeft(position, game, joystick, dt);
        isLeftSide = true;
        isRightSide = false;
        break;
      case JoystickDirection.left:
        _joyStickMoveLeft(position, game, joystick, dt);
        isLeftSide = true;
        isRightSide = false;
        break;
      case JoystickDirection.upRight:
        _joyStickMoveUp(position, joystick, dt);
        _joyStickMoveRight(position, game, joystick, dt);
        isRightSide = true;
        isLeftSide = false;
        break;
      case JoystickDirection.downRight:
        _joyStickMoveDown(position, game, joystick, dt);
        _joyStickMoveRight(position, game, joystick, dt);
        isRightSide = true;
        isLeftSide = false;
        break;
      case JoystickDirection.right:
        _joyStickMoveRight(position, game, joystick, dt);
        isRightSide = true;
        isLeftSide = false;
        break;
      case JoystickDirection.idle:
        break;
    }
    horizontalDirection += isLeftSide ? -1 : 0;
    horizontalDirection += isRightSide ? 1 : 0;
    _collisionSupporter.analyzeCollision();
    if (actorConfig.isTopDownRotate && joystick.delta.screenAngle() != 0) {
      component.angle = joystick.delta.screenAngle() - actorConfig.defaultAngle;
      return;
    }
    if (horizontalDirection < 0 && component.scale.x > 0) {
      component.flipHorizontally();
      return;
    }
    if (horizontalDirection > 0 && component.scale.x < 0) {
      component.flipHorizontally();
      return;
    }
  }

  void _joyStickMoveDown(
    NotifyingVector2 position,
    MobileGame game,
    GameJoystick joystick,
    double dt,
  ) {
    if (actorConfig.blockedGameSize) {
      if (position.y < game.size.y) {
        position.y += actorConfig.moveSpeed * joystick.delta.y * dt;
      }
    } else {
      position.y += actorConfig.moveSpeed * joystick.delta.y * dt;
    }
  }

  void _joyStickMoveUp(
    NotifyingVector2 position,
    GameJoystick joystick,
    double dt,
  ) {
    if (actorConfig.blockedGameSize) {
      if (position.y > 0) {
        position.y += actorConfig.moveSpeed * joystick.delta.y * dt;
      }
    } else {
      position.y += actorConfig.moveSpeed * joystick.delta.y * dt;
    }
  }

  void jump(bool jump) => hasJumped = jump;

  void addObstacleObject(PositionComponent object) {
    _collisionSupporter.addObstacleObject(object);
  }

  void removeObstacleObject(PositionComponent object) {
    _collisionSupporter.removeObstacleObject(object);
  }
}
