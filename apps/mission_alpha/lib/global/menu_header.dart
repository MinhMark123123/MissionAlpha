import 'package:flutter/material.dart';
import 'package:mission_alpha/game/mission_alpha_game.dart';
import 'package:mission_alpha/view/widgets/control_menu.dart';

class MenuHeader {
  MenuHeader._();

  static const keyControlMenu = "control_menu";

  static Widget menuControl(MissionAlphaGame game) => ControlMenu(game: game);
}
