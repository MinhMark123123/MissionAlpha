import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:mission_alpha/game/survivor_game.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<void>(
      future: Future.wait([
        Flame.device.fullScreen(),
        Flame.device.setLandscapeLeftOnly(),
        Future.delayed(const Duration(seconds: 1))
      ]),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return const GameWidget<SurvivorGame>.controlled(
            gameFactory: SurvivorGame.new,
          );
        }
        return const SizedBox.shrink();
      },
    );
  }
}
