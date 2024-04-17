
import 'package:mission_alpha/gen/assets.gen.dart';

extension AssetGenImageExtension on AssetGenImage{
  String get gameImageName => keyName.split("/").last;
}