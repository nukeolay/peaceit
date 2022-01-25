import 'package:flutter/material.dart';
// import 'package:makeitdark/core/models/cell.dart';
import 'package:makeitdark/core/models/game_field.dart';
import 'package:makeitdark/core/models/level.dart';
import 'package:makeitdark/core/models/user_data.dart';

class Game with ChangeNotifier {
  final List<Level> _levels;
  late GameField _gameField;
  late UserData _userData;
  int currentLevelNumber = 0;
  bool _isWin = false;
  bool _isInit = true;
  bool isSingleFlipOn = false;

  Game(this._levels);

  GameField get gameField => _gameField;

  UserData get userData => _userData;

  void initGame(GameField gameField, UserData userData) async {
    _gameField = gameField;
    _userData = userData;
    if (_isInit) {
      _gameField.setLevel(
        level: currentLevel.cells,
        solution: currentLevel.solution,
      );
      await _userData.loadUserData();
      _isInit = false;
    }
    _isWin = _gameField.isAllBlack;
    if (_isWin) {
      if (_userData.isLevelCompleted(currentLevelId)) {
        // если этот уровень уже был пройден
        int _currentLevelRating = _userData.getLevelRatingById(currentLevelId);
        switch (_currentLevelRating) {
          case 1:
            _userData.setLevelRatingById(
                levelId: currentLevelId, rating: rating());
            if (rating() == 3) {
              _userData.singleFlipsIncrement();
            }
            await _userData.saveUserData();
            break;
          case 2:
            if (rating() == 3) {
              _userData.setLevelRatingById(
                  levelId: currentLevelId, rating: rating());
              _userData.singleFlipsIncrement();
            }
            await _userData.saveUserData();
            break;
        }
      } else {
        // если этот уровень не был пройден ранее
        _userData.setCompletedLevel(
          CompletedLevel(
            id: currentLevelId,
            moves: _gameField.movesNumber,
            rating: rating(),
          ),
        );
        if ((currentLevelNumber + 1) != 0 &&
            ((currentLevelNumber + 1) % 10 == 0)) {
          _userData.solutionsNumberIncrement();
        }
        if (rating() == 3) {
          _userData.singleFlipsIncrement();
        }
        await _userData.saveUserData();
      }
    }
    notifyListeners();
  }

  int get singleFlips => _userData.singleFlips;

  void singleFlipsDecrement() {
    _userData.singleFlipsDecrement();
  }

  void singleFlipsIncrement() {
    _userData.singleFlipsIncrement();
  }

  bool canUseSingleFlips() {
    return singleFlips != 0 && gameField.solutionCell == null;
  }

  int get solutionsNumber => _userData.solutionsNumber;

  void solutionsNumberDecrement() {
    _userData.solutionsNumberDecrement();
  }

  void solutionsNumberIncrement() {
    _userData.solutionsNumberIncrement();
  }

  bool canUseSolution() {
    return solutionsNumber != 0 && gameField.solutionCell == null;
  }

  void useSingleFlip() {
    if (singleFlips > 0) {
      if (isSingleFlipOn) {
        isSingleFlipOn = false;
      } else {
        isSingleFlipOn = true;
      }
      notifyListeners();
    }
  }

  void useSolution() {
    if (solutionsNumber > 0) {
      restartLevel();
      _gameField.getSolution();
    }
  }

  Level get currentLevel => _levels[currentLevelNumber];

  String get currentLevelId => _levels[currentLevelNumber].id;

  List<Level> get levels => _levels;

  int get levelsNumber => _levels.length;

  bool get isWin => _isWin;

  bool get isGameFinished => levelsNumber == currentLevelNumber + 1;

  int rating() {
    if (_gameField.movesNumber <= currentLevel.bestResult) return 3;
    if (_gameField.movesNumber <= currentLevel.goodResult) return 2;
    return 1;
  }

  void nextLevel() {
    _isWin = false;
    isSingleFlipOn = false;
    currentLevelNumber++;
    _gameField.setLevel(
      level: currentLevel.cells,
      solution: currentLevel.solution,
    );
    notifyListeners();
  }

  void restartLevel() {
    _isWin = false;
    _gameField.resetField();
    isSingleFlipOn = false;
    notifyListeners();
  }

  void removeData() {
    _userData.removeData();
    currentLevelNumber = 0;
    _isWin = false;
    isSingleFlipOn = false;
    notifyListeners();
  }

  void setLevelById(String id) {
    _isWin = false;
    currentLevelNumber = levels.indexWhere((level) => level.id == id);
    _gameField.setLevel(
      level: getLevelById(id).cells,
      solution: getLevelById(id).solution,
    );
    notifyListeners();
  }

  Level getLevelById(String id) {
    return levels.firstWhere((level) => level.id == id);
  }
}
