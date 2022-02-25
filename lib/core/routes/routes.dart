import 'package:flutter/material.dart';

import 'package:darkit/presentation/game/view/game_screen.dart';
import 'package:darkit/presentation/home/view/home_screen.dart';
import 'package:darkit/presentation/level_completed/view/level_completed_screen.dart';
import 'package:darkit/presentation/select_chapter/view/select_chapter_screen.dart';
import 'package:darkit/presentation/select_level/view/select_level_screen.dart';
import 'package:darkit/presentation/game_finished/game_finished_screen.dart';
import 'package:darkit/presentation/level_constructor/view/level_constructor_screen.dart';
import 'package:darkit/presentation/tutorial/view/tutorial_screen.dart';
import 'package:darkit/presentation/tutorial/view/totorial_level_completed_screen.dart';

class Routes {
  static const String home = '/home-screen';
  static const String tutorial = '/tutorial-screen';
  static const String tutorialLevelCompleted =
      '/tutorial-level-completed-screen';
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
          case tutorial:
            return const TutorialScreen();
          case tutorialLevelCompleted:
            return const TutorialLevelCompletedScreen();
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
