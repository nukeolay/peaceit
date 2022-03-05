import 'package:flutter/material.dart';

import 'package:peaceit/presentation/game/view/game_screen.dart';
import 'package:peaceit/presentation/home/home_screen.dart';
import 'package:peaceit/presentation/level_completed/view/level_completed_screen.dart';
import 'package:peaceit/presentation/select_chapter/view/select_chapter_screen.dart';
import 'package:peaceit/presentation/select_level/view/select_level_screen.dart';
import 'package:peaceit/presentation/game_finished/game_finished_screen.dart';
import 'package:peaceit/presentation/level_constructor/view/level_constructor_screen.dart';

class Routes {
  static const String home = '/home-screen';
  static const String game = '/game-screen';
  static const String levelCompleted = '/level-completed-screen';
  static const String selectLevelMenu = '/select-level-menu-screen';
  static const String selectChapterMenu = '/select-chapter-menu-screen';
  static const String gameFinished = '/game-finished-screen';
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
            return const SelectLevelSreen();
          case selectChapterMenu:
            return const SelectChapterScreen();
          case gameFinished:
            return const GameFinishedScreen();
          case levelConstructor:
            return const LevelConstructorScreen();
          default:
            return const HomeScreen();
        }
      },
    );
  }
}
