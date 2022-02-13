import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:darkit/presentation/game/bottom_bar/view_model/view_model.dart';
import 'package:darkit/presentation/game/game_field_grid/view/game_field.dart';
import 'package:darkit/presentation/game/game_field_grid/view_model/view_model.dart';
import 'package:darkit/presentation/game/top_bar/view_model/view_model.dart';
import 'package:darkit/presentation/game/bottom_bar/view/bottom_bar.dart';
import 'package:darkit/presentation/game/top_bar/view/top_bar.dart';

class GameScreen extends StatelessWidget {
  const GameScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/bg.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 8.0,
              vertical: 10,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ChangeNotifierProvider<TopBarViewModel>(
                  create: (_) => TopBarViewModel(),
                  child: const TopBar(),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ChangeNotifierProvider<GameFieldViewModel>(
                      create: (_) => GameFieldViewModel(),
                      child: const GameField(),
                    ),
                  ],
                ),
                const Spacer(),
                ChangeNotifierProvider<BottomBarViewModel>(
                  create: (_) => BottomBarViewModel(),
                  child: const BottomBar(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
