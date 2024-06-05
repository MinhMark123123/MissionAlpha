import 'package:flame/components.dart';
import 'package:mobile_light/mobile_light.dart';

class PlatformCollisionSupporter {
  PlatformCollisionSupporter({required this.component}) {
    _init();
  }

  final PositionComponent component;
  final List<PositionComponent> _obstacleObjects = [];
  late _CollisionHandler _zeroHorizontal;
  late _CollisionHandler _zeroVertical;
  late _CollisionHandler _90Horizontal;
  late _CollisionHandler _90Vertical;

  void _init() {
    _zeroHorizontal = _CollisionHandler.zeroHorizontal(component);
    _zeroVertical = _CollisionHandler.zeroVertical(component);
    _90Horizontal = _CollisionHandler.ninetyHorizontal(component);
    _90Vertical = _CollisionHandler.ninetyVertical(component);
  }

  void addObstacleObject(PositionComponent object) {
    _obstacleObjects.add(object);
  }

  void removeObstacleObject(PositionComponent object) {
    _obstacleObjects.remove(object);
  }

  void analyzeCollision() {
    if (_obstacleObjects.isEmpty) return;
    for (final obstacle in _obstacleObjects) {
      if (obstacle is! SimplePlatformBlockComponent) {
        continue;
      }
      switch (obstacle.rotation) {
        case 0:
          {
            final conflictHorizontal = _zeroHorizontal.handleCollisionPosition(
              obstacle: obstacle,
            );
            if (conflictHorizontal) continue;
            _zeroVertical.handleCollisionPosition(obstacle: obstacle);
            continue;
          }
        case 90:
          {
            final conflictHorizontal = _90Horizontal.handleCollisionPosition(
              obstacle: obstacle,
            );
            if (conflictHorizontal) continue;
            _90Vertical.handleCollisionPosition(obstacle: obstacle);
            continue;
          }
      }
    }
  }
}

abstract class _CollisionHandler {
  _CollisionHandler({required this.component});

  factory _CollisionHandler.zeroHorizontal(PositionComponent component) {
    return _ZeroRotationHorizontalDetector(component: component);
  }

  factory _CollisionHandler.zeroVertical(PositionComponent component) {
    return _ZeroRotationVerticalDetector(component: component);
  }

  factory _CollisionHandler.ninetyHorizontal(PositionComponent component) {
    return _NinetyRotationHorizontalDetector(component: component);
  }

  factory _CollisionHandler.ninetyVertical(PositionComponent component) {
    return _NinetyRotationVerticalDetector(component: component);
  }

  final PositionComponent component;

  double get componentSize;

  double get componentHalfSize => componentSize / 2;

  double obstacleSize(PositionComponent obstacle);

  double obstacleHalfSize(PositionComponent obstacle) {
    return obstacleSize(obstacle) / 2;
  }

  bool handleCollisionPosition({required PositionComponent obstacle});
}

class _ZeroRotationHorizontalDetector extends _CollisionHandler {
  _ZeroRotationHorizontalDetector({required super.component});

  @override
  double get componentSize => component.size.x;

  @override
  double obstacleSize(PositionComponent obstacle) => obstacle.size.x;

  @override
  bool handleCollisionPosition({required PositionComponent obstacle}) {
    if (hasCollisionLeftSign(obstacle)) {
      final obstacleLeft = obstacle.position.x - obstacleHalfSize(obstacle);
      component.position.x = obstacleLeft - componentHalfSize;
      return true;
    }
    if (hasCollisionRightSign(obstacle)) {
      final obstacleRight = obstacle.position.x + obstacleHalfSize(obstacle);
      component.position.x = obstacleRight + componentHalfSize;
      return true;
    }
    return false;
  }

  bool hasCollisionLeftSign(PositionComponent obstacle) {
    final distanceObstacle = obstacle.position.x - obstacleHalfSize(obstacle);
    final distanceComponent = component.position.x + componentHalfSize;
    final condition1 = distanceObstacle <= distanceComponent;
    final condition2 = component.position.x < distanceObstacle;
    return condition1 && condition2;
  }

  bool hasCollisionRightSign(PositionComponent obstacle) {
    final distanceObstacle = obstacle.position.x + obstacleHalfSize(obstacle);
    final distanceComponent = component.position.x - componentHalfSize;
    final condition1 = distanceObstacle >= distanceComponent;
    final condition2 = component.position.x > distanceObstacle;
    return condition1 && condition2;
  }
}

class _ZeroRotationVerticalDetector extends _CollisionHandler {
  _ZeroRotationVerticalDetector({required super.component});

  @override
  double get componentSize => component.size.y;

  @override
  double obstacleSize(PositionComponent obstacle) => obstacle.size.y;

  @override
  bool handleCollisionPosition({required PositionComponent obstacle}) {
    if (hasCollisionTopSign(obstacle)) {
      final obstacleTop = obstacle.position.y - obstacleHalfSize(obstacle);
      component.position.y = obstacleTop - componentHalfSize;
      return true;
    }
    if (hasCollisionBottomSign(obstacle)) {
      final obstacleBottom = obstacle.position.y + obstacleHalfSize(obstacle);
      component.position.y = obstacleBottom + componentHalfSize;
      return true;
    }
    return false;
  }

  bool hasCollisionTopSign(PositionComponent obstacle) {
    final distanceObstacle = obstacle.position.y - obstacleHalfSize(obstacle);
    final distanceComponent = component.position.y + componentHalfSize;
    final condition1 = distanceObstacle <= distanceComponent;
    final condition2 = component.position.y < distanceObstacle;
    return condition1 && condition2;
  }

  bool hasCollisionBottomSign(PositionComponent obstacle) {
    final distanceObstacle = obstacle.position.y + obstacleHalfSize(obstacle);
    final distanceComponent = component.position.y - componentHalfSize;
    final condition1 = distanceObstacle >= distanceComponent;
    final condition2 = component.position.y > distanceObstacle;
    return condition1 && condition2;
  }
}

class _NinetyRotationHorizontalDetector
    extends _ZeroRotationHorizontalDetector {
  _NinetyRotationHorizontalDetector({required super.component});

  @override
  double get componentSize => component.size.x;

  @override
  double obstacleSize(PositionComponent obstacle) {
    return obstacle.size.y;
  }
}

class _NinetyRotationVerticalDetector extends _ZeroRotationVerticalDetector {
  _NinetyRotationVerticalDetector({required super.component});

  @override
  double get componentSize => component.size.y;

  @override
  double obstacleSize(PositionComponent obstacle) {
    return obstacle.size.x;
  }
}
