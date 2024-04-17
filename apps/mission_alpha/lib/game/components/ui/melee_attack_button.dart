import 'package:flame/components.dart';
import 'package:mission_alpha/game/components/base_component.dart';
import 'package:mission_alpha/game/mission_alpha_game.dart';
import 'package:mission_alpha/gen/assets.gen.dart';
import 'package:mission_alpha/global/game_size_const.dart';
import 'package:mission_alpha/utils/assets_gen_image_extension.dart';

class MeleeAttackButton extends BaseHudButtonComponent {
  final MissionAlphaGame missionAlphaGame;

  MeleeAttackButton(this.missionAlphaGame, {super.position})
      : super(
          button: SpriteComponent(
            sprite: Sprite(
              missionAlphaGame.images.fromCache(
                Assets.images.meleeAttack.gameImageName,
              ),
            ),
            size: Vector2.all(GameSizeConst.circleButtonSize),
          ),
          buttonDown: SpriteComponent(
            sprite: Sprite(
              missionAlphaGame.images.fromCache(
                Assets.images.meleeAttack.gameImageName,
              ),
            ),
            size: Vector2.all(GameSizeConst.circleButtonSize - 10),
          ),
          onPressed: () => missionAlphaGame.player.meleeAttack(),
          anchor: Anchor.center,
        );
}
