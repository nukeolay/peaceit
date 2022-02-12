import 'package:darkit/features/hints/domain/repositories/hints_repository.dart';
import 'package:darkit/features/hints/domain/usecases/single_flips_decrement.dart';
import 'package:darkit/features/hints/domain/usecases/single_flips_increment.dart';
import 'package:darkit/features/hints/domain/usecases/solutions_number_decrement.dart';
import 'package:darkit/features/hints/domain/usecases/solutions_number_increment.dart';
import 'package:darkit/features/levels/domain/entities/chapter_entity.dart';
import 'package:darkit/features/levels/domain/entities/level_entity.dart';
import 'package:darkit/features/levels/domain/repositories/levels_repository.dart';
import 'package:darkit/internal/service_locator.dart';
import 'package:darkit/old_realisation/models/game_field.dart';
import 'package:flutter/material.dart';

class Game with ChangeNotifier {
  late GameField _gameField;
  bool _isWin = false;
  bool isSingleFlipOn = false;

  final HintsRepository _hintsRepository = serviceLocator<HintsRepository>();
  final LevelsRepository _levelsRepository = serviceLocator<LevelsRepository>();

  GameField get gameField => _gameField;

  void initGame(GameField gameField) async {
    _gameField = gameField;
    _isWin = _gameField.isAllBlack;
    if (_isWin) {
      int newRating = rating();
      if (currentLevel.rating < newRating) {
        if (currentLevel.rating == 0) {
          // уровень до этого еще не проходили
          _levels[_levels.indexWhere((level) => level.id == currentLevelId)] =
              currentLevel.copyWith(rating: newRating);
          String _chapterId = _chapterIdByLevelId(currentLevelId);
          if (chapterByChapterId(_chapterId).completedRatio == 1) {
            // пройдены все уровни в главе
            await solutionsNumberIncrement();
          }
        }
        _levels[_levels.indexWhere((level) => level.id == currentLevelId)] =
            currentLevel.copyWith(rating: newRating);
        if (newRating == 3) {
          await singleFlipsIncrement();
        }
        await _levelsRepository.save(_levels);
      }
    }
    notifyListeners();
  }

  List<LevelEntity> get _levels => _levelsRepository.levels;

  bool get isFirstStart => _levels.where((level) => level.rating > 0).isEmpty;

  List<ChapterEntity> get chapters {
    List<ChapterEntity> chapters = [];
    List<String> chapterIds = [];
    for (LevelEntity level in _levels) {
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

  String _chapterIdByLevelId(String levelId) {
    return _levels.firstWhere((level) => level.id == levelId).chapterId;
  }

  ChapterEntity _chapterById(String chapterId) {
    return chapters.firstWhere((chapter) => chapter.id == chapterId);
  }

  int levelIndexInChapterById(String levelId) {
    final String chapterId = _chapterIdByLevelId(levelId);
    final ChapterEntity chapter = _chapterById(chapterId);
    return chapter.levelIndex(levelId);
  }

  ChapterEntity chapterByChapterId(String chapterId) {
    return chapters.firstWhere((chapter) => chapter.id == chapterId);
  }

  LevelEntity get currentLevel =>
      _levels.firstWhere((level) => level.id == currentLevelId);

  LevelEntity levelById(String levelId) {
    return _levels.firstWhere((level) => level.id == levelId);
  }

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

  // single flips

  int get singleFlips => _hintsRepository.hints.singleFlips;

  Future<void> singleFlipsDecrement() async {
    await SingleFlipsDecrement(_hintsRepository).call();
  }

  Future<void> singleFlipsIncrement() async {
    await SingleFlipsIncrement(_hintsRepository).call();
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

  int get solutionsNumber => _hintsRepository.hints.solutionsNumber;

  Future<void> solutionsNumberDecrement() async {
    await SolutionsNumberDecrement(_hintsRepository).call();
  }

  Future<void> solutionsNumberIncrement() async {
    await SolutionsNumberIncrement(_hintsRepository).call();
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
      _levels.where((level) => level.rating != 0).length == _levels.length;

  int rating() {
    // TODO сделать ById - ById уже есть. Этот метод используется для расчета значения от количества ходов. Передавать сюда Id и количество ходов. Или оставить все без изменения
    if (_gameField.movesNumber <= currentLevel.bestResult) return 3;
    if (_gameField.movesNumber <= currentLevel.goodResult) return 2;
    return 1;
  }
}
