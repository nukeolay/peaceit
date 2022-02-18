import 'package:darkit/old_realisation/game/screens/game_finished_screen.dart';
import 'package:darkit/presentation/game/screen/game_screen.dart';
import 'package:darkit/presentation/home/home_screen.dart';
import 'package:darkit/old_realisation/how_to_play/screens/how_to_play_screen.dart';
import 'package:darkit/old_realisation/level_constructor/screens/level_constructor_screen.dart';
import 'package:darkit/old_realisation/tutorial/screens/toturial_screen.dart';
import 'package:darkit/presentation/level_completed/view/level_completed_screen.dart';
import 'package:darkit/presentation/select_chapter/view/select_chapter_view.dart';
import 'package:darkit/presentation/select_level/view/select_level_view.dart';
import 'package:flutter/material.dart';

class Routes {
  static const String home = '/home-screen';
  static const String game = '/game-screen';
  static const String levelCompleted = '/level-completed-screen';
  static const String selectLevelMenu = '/select-level-menu-screen';
  static const String selectChapterMenu = '/select-chapter-menu-screen';
  static const String gameFinished = '/game-finished-screen';
  static const String howToPlay = '/how-to-play-screen';
  static const String tutorial = '/tutorial-screen';
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
            return const SelectLevelView();
          case selectChapterMenu:
            return const SelectChapterView();
          case gameFinished:
            return const GameFinishedScreen();
          case howToPlay:
            return const HowToPlayScreen();
          case tutorial:
            return const TutorialScreen();
          case levelConstructor:
            return const LevelConstructorScreen();
          default:
            return const HomeScreen();
        }
      },
    );
  }
}
