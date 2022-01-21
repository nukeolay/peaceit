import 'package:flutter/material.dart';
import 'package:makeitdark/models/game_field.dart';
import 'package:makeitdark/models/level.dart';

class Game with ChangeNotifier {
  final List<Level> _levels;
  late GameField _gameField;
  int currentLevelNumber = 0;
  bool _isWin = false;
  bool _isInit = true;
  bool isGameStarted = false;
  int helpFlips = 3;

  Game(this._levels);

  GameField get gameField => _gameField;

  set gameField(GameField gameField) {
    _gameField = gameField;
    if (_isInit) {
      _gameField.setLevel(currentLevel.cells);
      _isInit = false;
    }
    _isWin = _gameField.isAllBlack;
    notifyListeners();
  }

  Level get currentLevel => _levels[currentLevelNumber];

  List<Level> get levels => _levels;

  int get levelsNumber => _levels.length;

  bool get isWin => _isWin;

  int rating() {
    if (_gameField.movesNumber <= currentLevel.bestResult) return 3;
    if (_gameField.movesNumber <= currentLevel.goodResult) return 2;
    return 1;
  }

  void nextLevel() {
    _isWin = false;
    currentLevelNumber++;
    _gameField.setLevel(currentLevel.cells);
    notifyListeners();
  }

  void restart() {
    _isWin = false;
    _gameField.resetField();
    notifyListeners();
  }
}
