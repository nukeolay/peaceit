import 'package:darkit/features/hints/domain/usecases/reset_hints.dart';
import 'package:darkit/features/hints/domain/usecases/single_flips_decrement.dart';
import 'package:darkit/features/hints/domain/usecases/single_flips_increment.dart';
import 'package:darkit/features/hints/domain/usecases/solutions_number_decrement.dart';
import 'package:darkit/features/hints/domain/usecases/solutions_number_increment.dart';
import 'package:darkit/features/levels/domain/entities/chapter_entity.dart';
import 'package:darkit/features/levels/domain/entities/level_entity.dart';
import 'package:darkit/features/levels/domain/entities/levels_entity.dart';
import 'package:darkit/features/levels/domain/repositories/levels_repository.dart';
import 'package:darkit/features/levels/domain/usecases/reset_levels.dart';
import 'package:darkit/internal/dependencies/hints_repository_module.dart';
import 'package:darkit/internal/dependencies/levels_repository_module%20copy.dart';
// import 'package:darkit/internal/dependencies/repository_module.dart';
import 'package:flutter/material.dart';
import 'package:darkit/core/models/game_field.dart';
// import 'package:darkit/core/models/level.dart';
// import 'package:darkit/core/models/levels.dart';
// import 'package:darkit/domain/entities/user_data.dart';

class Game with ChangeNotifier {
  // Levels _levels;

  late GameField _gameField;
  // late UserData _userData;
  // late LevelsEntity _levels;
  bool _isWin = false;
  bool _isInit = true;
  bool isSingleFlipOn = false;

  // Game(this._levels);

  GameField get gameField => _gameField;

  void initGame(GameField gameField) async {
    // TODO может быть сюда не передавать UserData, а просто вызывать его тут внутри
    _gameField = gameField;
    if (_isInit) {
      // await _loadUserData();
      await HintsRepositoryModule.hintsRepository.load();
      await LevelsRepositoryModule.levelsRepository.load();
      _isInit = false;
    }
    _isWin = _gameField.isAllBlack;
    if (_isWin) {
      int newRating = rating();
      if (currentLevel.rating < newRating) {
        if (currentLevel.rating == 0) {
          // уровень до этого еще не проходили
          // currentLevel.rating = newRating;
          _levels.levels[levelIndexById(currentLevelId)] =
              currentLevel.copyWith(rating: newRating);
          // _userData.completedLevels[currentLevel.id] = CompletedLevel(
          //   id: currentLevel.id,
          //   rating: currentLevel.rating,
          // );
          String _chapterId = _chapterIdByLevelId(currentLevelId);
          if (chapterByChapterId(_chapterId).completedRatio == 1) {
            // пройдены все уровни в главе
            await solutionsNumberIncrement();
          }
        }
        // currentLevel.rating = newRating;
        _levels.levels[levelIndexById(currentLevelId)] = currentLevel.copyWith(
            rating: newRating); // TODO может это не нужно? ранее уже
        if (newRating == 3) {
          await singleFlipsIncrement();
        }
        await LevelsRepositoryModule.levelsRepository.save(_levels);
        // await _saveUserData();
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

  LevelsEntity get _levels => LevelsRepositoryModule.levelsRepository.levels;

  bool get isFirstStart =>
      _levels.levels.where((level) => level.rating > 0).isEmpty;

  List<ChapterEntity> get chapters {
    List<ChapterEntity> chapters = [];
    List<String> chapterIds = [];
    for (LevelEntity level in _levels.levels) {
      if (!chapterIds.contains(level.chapterId)) {
        chapterIds.add(level.chapterId);
        chapters.add(ChapterEntity(id: level.chapterId, levels: [level]));
      } else {
        chapters
            .firstWhere((chapter) => chapter.id == level.chapterId)
            .levels
            .add(level);
      }
    }
    return chapters;
  }

  LevelEntity _levelById(String levelId) {
    return _levels.levels.firstWhere((level) => level.id == levelId);
  }

  int levelRatingById(String levelId) => _levelById(levelId).rating;

  String _chapterIdByLevelId(String levelId) {
    return _levels.levels.firstWhere((level) => level.id == levelId).chapterId;
  }

  ChapterEntity _chapterById(String chapterId) {
    return chapters.firstWhere((chapter) => chapter.id == chapterId);
  }

  bool canBeLevelPlayed(String levelId) {
    final String chapterId = _chapterIdByLevelId(levelId);
    final ChapterEntity chapter = _chapterById(chapterId);
    final int index = chapter.levelIndexById(levelId);
    return chapter.completedLevelsNumber >=
        index; // TODO если + 1 то будет открываться по 2 уровня
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
    final String chapterId = _chapterIdByLevelId(levelId);
    final ChapterEntity chapter = _chapterById(chapterId);
    return chapter.levels[_levelIndex + 1].id;
  }

  int levelIndexById(String levelId) {
    return _levels.levels
        .indexOf(_levels.levels.firstWhere((level) => level.id == levelId));
  }

  List<LevelEntity> levelsByChapterId(String chapterId) {
    return _levels.levels
        .where((level) => level.chapterId == chapterId)
        .toList();
  }

  ChapterEntity chapterByChapterId(String chapterId) {
    return chapters.firstWhere((chapter) => chapter.id == chapterId);
  }

  LevelEntity get currentLevel =>
      _levels.levels.firstWhere((level) => level.id == currentLevelId);

  int get levelsQuantity => _levels.levels.length;

  LevelEntity levelById(String levelId) {
    return _levels.levels.firstWhere((level) => level.id == levelId);
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

  // Future<void> _saveUserData() async {
  //   await RepositoryModule.userDataRepository.save();
  // }

  // Future<void> _loadUserData() async {
  // await RepositoryModule.userDataRepository.load();
  // await HintsRepositoryModule.hintsRepository.load();
  // await LevelsRepositoryModule.levelsRepository.load();
  // _userData = RepositoryModule.userDataRepository.userData;
  // загружаю информацию о пройденных уровнях (рейтинг)
  // for (CompletedLevel completedLevel in _userData.completedLevels.values) {
  //   _levels._levels.levels
  //       .firstWhere((level) => level.id == completedLevel.id)
  //       .rating = completedLevel.rating;
  // }
  // }

  Future<void> removeData() async {
    // _levels = Levels();
    isSingleFlipOn = false;
    _isWin = false;
    // _userData.completedLevels = {};
    ResetLevels(LevelsRepositoryModule.levelsRepository);
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
      _levels.levels.where((level) => level.rating != 0).length ==
      _levels.levels.length;

  int rating() {
    // TODO сделать ById - ById уже есть. Этот метод используется для расчета значения от количества ходов. Передавать сюда Id и количество ходов. Или оставить все без изменения
    if (_gameField.movesNumber <= currentLevel.bestResult) return 3;
    if (_gameField.movesNumber <= currentLevel.goodResult) return 2;
    return 1;
  }
}
