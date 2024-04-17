import 'package:flutter/material.dart';
import 'package:mission_alpha/game/mission_alpha_game.dart';

abstract class BaseMenu extends StatelessWidget {
  final MissionAlphaGame game;
  const BaseMenu({super.key, required this.game});

  @override
  Widget build(BuildContext context) {
    return Material(color: Colors.transparent, child: buildMenuUI(context));
  }

  Widget buildMenuUI(BuildContext context);
}
