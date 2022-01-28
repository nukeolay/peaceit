import 'package:flutter/material.dart';
import 'package:darkit/core/constants/initial_game_settings.dart';
import 'package:darkit/core/models/game_field.dart';
import 'package:darkit/core/models/level.dart';
import 'package:darkit/core/models/levels.dart';
import 'package:darkit/core/models/user_data.dart';

class Game with ChangeNotifier {
  Levels _levels;

  late GameField _gameField;
  late UserData _userData;
  bool _isWin = false;
  bool _isInit = true;
  bool isSingleFlipOn = false;
  late int _singleFlips;
  late int _solutionsNumber;

  Game(this._levels);

  GameField get gameField => _gameField;

  void initGame(GameField gameField, UserData userData) async {
    // TODO может быть сюда не передавать UserData, а просто вызывать его тут внутри
    _gameField = gameField;
    _userData = userData;
    if (_isInit) {
      await _loadUserData();
      _isInit = false;
    }
    _isWin = _gameField.isAllBlack;
    if (_isWin) {
      int newRating = rating();

      if (currentLevel.rating < newRating) {
        if (currentLevel.rating == 0) {
          // уровень до этого еще не проходили
          currentLevel.rating = newRating;
          String _chapterId = _levels.chapterIdByLevelId(currentLevelId);
          if (chapterByChapterId(_chapterId).completedRatio == 1) {
            // пройдены все уровни в главе
            solutionsNumberIncrement();
          }
        }
        currentLevel.rating = newRating;
        if (newRating == 3) {
          singleFlipsIncrement();
        }
        await _saveUserData(this);
      }
    }
    notifyListeners();
  }

  // levels and chapters

  List<Level> get allLevels => _levels.allLevels;

  List<Chapter> get chapters => _levels.chapters();

  int levelRatingById(String levelId) {
    return _levels.levelById(levelId).rating;
  }

  bool canBeLevelPlayed(String levelId) {
    final String chapterId = _levels.chapterIdByLevelId(levelId);
    final Chapter chapter = _levels.chapterById(chapterId);
    final int index = chapter.levelIndexById(levelId);
    return chapter.completedLevelsNumber + 1 >= index;
  }

  bool canBeChapterPlayed(String chapterId) {
    try {
      int _previousChapterIndex =
          chapters.indexWhere((chapter) => chapter.id == chapterId) - 1;
      return chapters[_previousChapterIndex].completedRatio > 0.7;
    } catch (error) {
      return true;
    }
  }

  String nextLevelIdByPreviousId(String levelId) {
    int _levelIndex = levelIndexById(levelId);
    final String chapterId = _levels.chapterIdByLevelId(levelId);
    final Chapter chapter = _levels.chapterById(chapterId);
    return chapter.levels[_levelIndex + 1].id;
  }

  int levelIndexById(String levelId) {
    String _chapterId = levelById(levelId).chapterId;
    final Chapter _chapter = _levels.chapterById(_chapterId);
    return _chapter.levelIndexById(levelId);
  }

  List<Level> levelsByChapterId(String chapterId) {
    return _levels.levelsByChapterId(chapterId);
  }

  Chapter chapterByChapterId(String chapterId) {
    return chapters.firstWhere((chapter) => chapter.id == chapterId);
  }

  Level get currentLevel =>
      allLevels.firstWhere((level) => level.id == currentLevelId);

  String get currentLevelId => _gameField.levelId;

  int get allLevelsQuantity => allLevels.length;

  void restartLevel() {
    _isWin = false;
    _gameField.resetField();
    isSingleFlipOn = false;
    notifyListeners();
  }

  void setLevelById(String levelId) {
    _isWin = false;
    isSingleFlipOn = false;
    _gameField.setLevel(
      levelId: levelId,
      level: levelById(levelId).cells,
      solution: levelById(levelId).solution,
    );
  }

  Level levelById(String levelId) {
    return allLevels.firstWhere((level) => level.id == levelId);
  }

  // user data

  Future<void> _saveUserData(Game game) async {
    await _userData.saveUserData(this);
  }

  Future<void> _loadUserData() async {
    await _userData.loadUserData();
    _singleFlips = _userData.singleFlips;
    _solutionsNumber = _userData.solutionsNumber;
    // загружаю информацию о пройденных уровнях (рейтинг)
    for (CompletedLevel completedLevel in _userData.completedLevels.values) {
      _levels.allLevels
          .firstWhere((level) => level.id == completedLevel.id)
          .rating = completedLevel.rating;
    }
  }

  Future<void> removeData() async {
    _levels = Levels();
    _singleFlips = InitialGameSettings.singleFlips;
    _solutionsNumber = InitialGameSettings.solutionsNumber;
    isSingleFlipOn = false;
    _isWin = false;
    await _saveUserData(this);
    notifyListeners();
  }

  // single flips

  int get singleFlips => _singleFlips;

  void singleFlipsDecrement() {
    _singleFlips--;
  }

  void singleFlipsIncrement() {
    _singleFlips++;
  }

  bool canUseSingleFlips() {
    return singleFlips != 0 && gameField.solutionCell == null;
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

  // solutions

  int get solutionsNumber => _solutionsNumber;

  void solutionsNumberDecrement() {
    _solutionsNumber--;
  }

  void solutionsNumberIncrement() {
    _solutionsNumber++;
  }

  bool canUseSolution() {
    return solutionsNumber != 0 && gameField.solutionCell == null;
  }

  void useSolution() {
    if (solutionsNumber > 0) {
      restartLevel();
      _gameField.getSolution();
    }
  }

  // play

  bool get isWin => _isWin;

  bool get isGameFinished =>
      allLevels.where((level) => level.rating != 0).length == allLevels.length;

  int rating() {
    // TODO сделать ById - ById уже есть. Этот метод используется для расчета значения от количества ходов. Передавать сюда Id и количество ходов. Или оставить все без изменения
    if (_gameField.movesNumber <= currentLevel.bestResult) return 3;
    if (_gameField.movesNumber <= currentLevel.goodResult) return 2;
    return 1;
  }
}
