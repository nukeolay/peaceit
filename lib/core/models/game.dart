import 'package:darkit/features/hints/domain/entities/hints_entity.dart';
import 'package:darkit/features/hints/domain/usecases/reset_hints.dart';
import 'package:darkit/features/hints/domain/usecases/single_flips_decrement.dart';
import 'package:darkit/features/hints/domain/usecases/single_flips_increment.dart';
import 'package:darkit/features/hints/domain/usecases/solutions_number_decrement.dart';
import 'package:darkit/features/hints/domain/usecases/solutions_number_increment.dart';
import 'package:darkit/features/levels/domain/entities/levels_entity.dart';
import 'package:darkit/internal/dependencies/hints_repository_module.dart';
import 'package:darkit/internal/dependencies/repository_module.dart';
import 'package:flutter/material.dart';
import 'package:darkit/core/models/game_field.dart';
import 'package:darkit/core/models/level.dart';
import 'package:darkit/core/models/levels.dart';
import 'package:darkit/domain/entities/user_data.dart';

class Game with ChangeNotifier {
  Levels _levels;

  late GameField _gameField;
  late UserData _userData;
  // late HintsEntity _hints;
  // late LevelsEntity _levels;
  bool _isWin = false;
  bool _isInit = true;
  bool isSingleFlipOn = false;

  Game(this._levels);

  GameField get gameField => _gameField;

  void initGame(GameField gameField) async {
    // TODO может быть сюда не передавать UserData, а просто вызывать его тут внутри
    _gameField = gameField;
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
          _userData.completedLevels[currentLevel.id] = CompletedLevel(
            id: currentLevel.id,
            rating: currentLevel.rating,
          );
          String _chapterId = _levels.chapterIdByLevelId(currentLevelId);
          if (chapterByChapterId(_chapterId).completedRatio == 1) {
            // пройдены все уровни в главе
            await solutionsNumberIncrement();
          }
        }
        currentLevel.rating = newRating;
        if (newRating == 3) {
          await singleFlipsIncrement();
        }
        await _saveUserData();
      }
    }
    notifyListeners();
  }

  // levels and chapters
  //
  //
  // функции, обращающиеся только к классу Levels
  //
  //

  bool get isFirstStart => _levels.isFirstStart;

  List<Level> get allLevels => _levels.allLevels;

  List<Chapter> get chapters => _levels.chapters;

  int levelRatingById(String levelId) => _levels.levelRatingById(levelId);

  bool canBeLevelPlayed(String levelId) => _levels.canBeLevelPlayed(levelId);

  bool canBeChapterPlayed(String chapterId) =>
      _levels.canBeChapterPlayed(chapterId);

  String nextLevelIdByPreviousId(String levelId) =>
      _levels.nextLevelIdByPreviousId(levelId);

  int levelIndexById(String levelId) => _levels.levelIndexById(levelId);

  List<Level> levelsByChapterId(String chapterId) {
    return _levels.levelsByChapterId(chapterId);
  }

  Chapter chapterByChapterId(String chapterId) =>
      _levels.chapterByChapterId(chapterId);

  Level get currentLevel =>
      allLevels.firstWhere((level) => level.id == currentLevelId);

  int get allLevelsQuantity => allLevels.length;

  Level levelById(String levelId) {
    return allLevels.firstWhere((level) => level.id == levelId);
  }

  //
  //
  // функции, обращающиеся только к классу Levels
  //
  //

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

  String get currentLevelId => _gameField.levelId;

  // user data

  Future<void> _saveUserData() async {
    await RepositoryModule.userDataRepository.save();
  }

  Future<void> _loadUserData() async {
    await RepositoryModule.userDataRepository.load();
    await HintsRepositoryModule.hintsRepository.load();
    _userData = RepositoryModule.userDataRepository.userData;
    // _hints = HintsRepositoryModule.hintsRepository.hints;
    // загружаю информацию о пройденных уровнях (рейтинг)
    for (CompletedLevel completedLevel in _userData.completedLevels.values) {
      _levels.allLevels
          .firstWhere((level) => level.id == completedLevel.id)
          .rating = completedLevel.rating;
    }
  }

  Future<void> removeData() async {
    _levels = Levels();
    isSingleFlipOn = false;
    _isWin = false;
    _userData.completedLevels = {};
    await ResetHints(HintsRepositoryModule.hintsRepository).call();
    notifyListeners();
  }

  // single flips

  int get singleFlips =>
      HintsRepositoryModule.hintsRepository.hints.singleFlips;

  Future<void> singleFlipsDecrement() async {
    await SingleFlipsDecrement(HintsRepositoryModule.hintsRepository).call();
  }

  Future<void> singleFlipsIncrement() async {
    await SingleFlipsIncrement(HintsRepositoryModule.hintsRepository).call();
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

  int get solutionsNumber =>
      HintsRepositoryModule.hintsRepository.hints.solutionsNumber;

  Future<void> solutionsNumberDecrement() async {
    await SolutionsNumberDecrement(HintsRepositoryModule.hintsRepository)
        .call();
  }

  Future<void> solutionsNumberIncrement() async {
    await SolutionsNumberIncrement(HintsRepositoryModule.hintsRepository)
        .call();
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
