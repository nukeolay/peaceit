import 'package:flutter/material.dart';
import 'package:makeitdark/features/game/screens/game_screen.dart';
import 'package:makeitdark/features/select_level_menu/screens/select_level_menu_screen.dart';
import 'package:makeitdark/screens/home_screen.dart';
import 'package:makeitdark/features/game/screens/level_completed_screen.dart';

class Routes {
  static const String home = '/home-screen';
  static const String game = '/game-screen';
  static const String test = '/test-screen';
  static const String levelCompleted = '/level-completed-screen';
  static const String selectLevelMenu = '/select-level-menu-screen';

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
          default:
            return const HomeScreen();
        }
      },
    );
  }
}
