import 'package:mission_alpha/game/level/base_level.dart';
import 'package:mission_alpha/gen/assets.gen.dart';
import 'package:mission_alpha/utils/assets_gen_image_extension.dart';

class Level1 extends BaseLevel {
  Level1({super.position});

  @override
  String get assetMapPath => Assets.tiles.level1Tmx.gameTilesName;
}
