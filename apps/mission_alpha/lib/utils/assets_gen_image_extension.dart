import 'package:mission_alpha/gen/assets.gen.dart';

extension AssetGenImageExtension on AssetGenImage{
  String get gameImageName => keyName.replaceAll("assets/images/", "");
}
extension StringGamePath on String{
  String get gameTilesName => replaceAll("assets/tiles/", "");
}