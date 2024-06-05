import 'dart:async';
import 'package:flame/components.dart';
import 'package:flame_tiled/flame_tiled.dart';
import 'package:mission_alpha/game/components/enemies/zombie_enemy.dart';
import 'package:mission_alpha/game/components/objects/platform_block_component.dart';
import 'package:mission_alpha/game/components/player/survivor_player.dart';
import 'package:mission_alpha/game/mission_alpha_game.dart';
import 'package:mission_alpha/utils/app_utils.dart';

abstract class BaseLevel extends PositionComponent
    with HasGameReference<MissionAlphaGame> {
  BaseLevel({super.position});

  late final TiledComponent map;

  String get assetMapPath;

  Vector2 get assetMapSize => Vector2.all(32);
  late SurvivorPlayer player;
  final List<PlatformBlockComponent> _platformBlock =
      <PlatformBlockComponent>[];

  List<PlatformBlockComponent> get platformBlock => _platformBlock;

  @override
  FutureOr<void> onLoad() async {
    await super.onLoad();
    map = await TiledComponent.load(assetMapPath, assetMapSize);
    game.world.add(map);
    generateSpawn();
    generateCollision();
    game.applyFollowCamera();
  }

  void generateSpawn() {
    final spawnPoints = map.tileMap.getLayer<ObjectGroup>("spawn_points");
    spawnPoints?.objects.forEach((element) {
      switch (element.class_) {
        case "player":
          player = SurvivorPlayer(position: Vector2(element.x, element.y));
          game.addPlayerToWorld(player);
          break;
        case "zombie_1":
          final zombie = ZombieEnemy(position: Vector2(element.x, element.y));
          game.addToWorld(zombie);
          break;
      }
    });
  }

  void generateCollision() {
    final collisions = map.tileMap.getLayer<ObjectGroup>("collisions");
    collisions?.objects.forEach((element) {
      switch (element.class_) {
        case "platform":
          _initPlatformBlock(element);
          break;
      }
    });
  }

  void _initPlatformBlock(TiledObject element) {
    print("${Vector2Util.degreesToRads(element.rotation)}");
    var position = Vector2.zero();
    switch (element.rotation) {
      case 0.0:
        position = Vector2(
          element.x + element.size.x / 2,
          element.y + element.size.y / 2,
        );
        break;
      case 90.0:
        position = Vector2(
          element.x - element.size.y / 2,
          element.y + element.size.x / 2,
        );
        break;
    }
    final block = PlatformBlockComponent(
      position: position,
      size: element.size,
      angle: Vector2Util.degreesToRads(element.rotation),
      rotation: element.rotation,
    );
    game.addToWorld(block);
    _platformBlock.add(block);
  }
}
