import 'package:flutter/material.dart';
import 'package:makeitdark/models/cell.dart';
import 'package:makeitdark/models/game_field.dart';
import 'package:makeitdark/models/level.dart';

class Game with ChangeNotifier {
  final List<Level> levels;
  final GameField gameField;
  Level? currentLevel;
  int currentLevelNumber = 0;
  bool _isWin = false;

  Game({
    required this.levels,
    required this.gameField,
  });

  int get levelsNumber => levels.length;

  bool get isWin => _isWin;

  void setCurrentLevel() {
    currentLevel = Level(
      cells: [
        ...levels[currentLevelNumber]
            .cells
            .map((cell) => Cell(cell.x, cell.y, cell.isBlack))
            .toList()
      ],
      bestResult: levels[currentLevelNumber].bestResult,
      goodResult: levels[currentLevelNumber].goodResult,
      badResult: levels[currentLevelNumber].badResult,
    );
  }

  void nextLevel() {
    _isWin = false;
    gameField!.movesNumber = 0;
    currentLevelNumber++;
    setCurrentLevel();
    notifyListeners();
  }

  void restart() {
    _isWin = false;
    gameField!.movesNumber = 0;
    setCurrentLevel();
    notifyListeners();
  }
}
