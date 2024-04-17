import 'package:flutter/material.dart';
import 'package:mission_alpha/view/widgets/base_menu.dart';
import 'package:mission_alpha/view/widgets/game_circle_button.dart';

class ControlMenu extends BaseMenu {
  const ControlMenu({super.key, required super.game});

  @override
  Widget buildMenuUI(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          right: 32,
          bottom: 32,
          child: GameCircleButton(
            color: Colors.white70,
            child: const Icon(Icons.my_location, size: 54,),
            onTapDown: () {},
            onTapUp: () {},
          ),
        )
      ],
    );
  }
}
