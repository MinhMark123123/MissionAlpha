import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:mission_alpha/game/mission_alpha_game.dart';
import 'package:mission_alpha/global/menu_header.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<void>(
      future: _prepareGameProcess(),
      builder: (context, snapshot) {
        if (snapshot.connectionState != ConnectionState.done) {
          return const SizedBox.shrink();
        }
        return GameWidget<MissionAlphaGame>.controlled(
          overlayBuilderMap: {
            MenuHeader.keyControlMenu: (_, game) => MenuHeader.menuControl(game)
          },
          gameFactory: MissionAlphaGame.new,
        );
      },
    );
  }

  Future<void> _prepareGameProcess() async {
    await Flame.device.fullScreen();
    await Future.delayed(const Duration(milliseconds: 300));
    await Flame.device.setLandscapeLeftOnly();
    await Future.delayed(const Duration(milliseconds: 300));
  }
}
