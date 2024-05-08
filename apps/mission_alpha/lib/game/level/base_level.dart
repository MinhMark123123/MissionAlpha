import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame_tiled/flame_tiled.dart';
import 'package:mission_alpha/game/components/enemies/zombie_enemy.dart';
import 'package:mission_alpha/game/components/player/survivor_player.dart';
import 'package:mission_alpha/game/mission_alpha_game.dart';

abstract class BaseLevel extends PositionComponent
    with HasGameReference<MissionAlphaGame> {
  BaseLevel({super.position});

  late final TiledComponent map;

  String get assetMapPath;

  Vector2 get assetMapSize => Vector2.all(32);
  late SurvivorPlayer player;


  @override
  FutureOr<void> onLoad() async {
    await super.onLoad();
    map = await TiledComponent.load(assetMapPath, assetMapSize);
    game.world.add(map);
    initActors();
    game.applyFollowCamera();
  }

  void initActors() {
    final spawnPoints = map.tileMap.getLayer<ObjectGroup>("spawn_points");
    spawnPoints?.objects.forEach((element) {
      switch(element.class_){
        case "player":
          player = SurvivorPlayer(position: Vector2(element.x, element.y));
          add(player);
          game.player = player;
          break;
        case "zombie_1":
          final zombie = ZombieEnemy(position: Vector2(element.x, element.y));
          add(zombie);
          break;
      }
    });
  }
}
