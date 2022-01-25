import 'package:flutter/material.dart';
import 'package:makeitdark/features/game/screens/game_finished_screen.dart';
import 'package:makeitdark/features/game/screens/game_screen.dart';
import 'package:makeitdark/features/how_to_play/screens/how_to_play_screen.dart';
import 'package:makeitdark/features/level_constructor/screens/level_constructor_screen.dart';
import 'package:makeitdark/features/select_level_menu/screens/select_level_menu_screen.dart';
import 'package:makeitdark/features/home/screens/home_screen.dart';
import 'package:makeitdark/features/game/screens/level_completed_screen.dart';

class Routes {
  static const String home = '/home-screen';
  static const String game = '/game-screen';
  static const String levelCompleted = '/level-completed-screen';
  static const String selectLevelMenu = '/select-level-menu-screen';
  static const String gameFinished = '/game-finished-screen';
  static const String howToPlay = '/how-to-play-screen';
  static const String levelConstructor = '/level-constructor-screen';

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    return MaterialPageRoute(
      settings: settings,
      builder: (context) {
        switch (settings.name) {
          case home:
            return const HomeScreen();
          case game:
            return const GameScreen();
          case levelCompleted:
            return const LevelCompletedScreen();
          case selectLevelMenu:
            return const SelectLevelMenuScreen();
          case gameFinished:
            return const GameFinishedScreen();
          case howToPlay:
            return const HowToPlayScreen();
          case levelConstructor:
            return const LevelConstructorScreen();
          default:
            return const HomeScreen();
        }
      },
    );
  }
}
