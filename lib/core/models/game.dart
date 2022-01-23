import 'package:flutter/material.dart';
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
  bool isGameStarted = false;

  Game(this._levels);

  GameField get gameField => _gameField;

  UserData get userData => _userData;

  void initGame(GameField gameField, UserData userData) async {
    _gameField = gameField;
    _userData = userData;
    if (_isInit) {
      _gameField.setLevel(currentLevel.cells);
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
            await _userData.saveUserData(); // TODO тут асинхронность
            break;
          case 2:
            if (rating() == 3) {
              _userData.setLevelRatingById(
                  levelId: currentLevelId, rating: rating());
              _userData.singleFlipsIncrement();
            }
            await _userData.saveUserData(); // TODO тут асинхронность
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
        if (rating() == 3) {
          _userData.singleFlipsIncrement();
        }
        await _userData.saveUserData(); // TODO тут асинхронность
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

  void useSingeFlip() {
    if (singleFlips > 0) {
      if (isSingleFlipOn) {
        isSingleFlipOn = false;
      } else {
        isSingleFlipOn = true;
      }
      notifyListeners();
    }
  }

  Level get currentLevel => _levels[currentLevelNumber];

  String get currentLevelId => _levels[currentLevelNumber].id;

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

  void restartLevel() {
    _isWin = false;
    _gameField.resetField();
    notifyListeners();
  }

  void removeData() {
    _userData.removeData();
    currentLevelNumber = 0;
    _isWin = false;
    isSingleFlipOn = false;
    isGameStarted = false;
    notifyListeners();
  }

  void setLevelById(String id) {
    _isWin = false;
    currentLevelNumber = levels.indexWhere((level) => level.id == id);
    _gameField.setLevel(levels.firstWhere((level) => level.id == id).cells);
    notifyListeners();
  }
}
