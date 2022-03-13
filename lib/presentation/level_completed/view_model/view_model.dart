import 'package:flutter/material.dart';

import 'package:peaceit/core/constants/default_game_settings.dart';
import 'package:peaceit/internal/service_locator.dart';
import 'package:peaceit/domain/hints/usecases/single_flips_increment.dart';
import 'package:peaceit/domain/hints/usecases/solutions_number_increment.dart';
import 'package:peaceit/domain/levels/entities/chapter_entity.dart';
import 'package:peaceit/domain/levels/usecases/complete_level.dart';
import 'package:peaceit/domain/levels/usecases/get_chapers.dart';
import 'package:peaceit/domain/levels/entities/level_entity.dart';
import 'package:peaceit/domain/levels/usecases/get_levels.dart';
import 'package:peaceit/presentation/level_completed/view_model/view_model_state.dart';

class LevelCompletedViewModel extends ChangeNotifier {
  LevelCompletedViewModelState _state = LevelCompletedViewModelState();

  LevelCompletedViewModelState get state => _state;

  final String _levelId;
  final int _moves;
  late final LevelEntity _level;
  late ChapterEntity _chapter;
  late final int _previousRating;
  late final double _previousCompleteRatio;

  LevelCompletedViewModel(this._levelId, this._moves) {
    _init();
  }

  void _init() {
    _level = serviceLocator<GetLevels>()
        .call()
        .firstWhere((level) => level.id == _levelId);
    _chapter = serviceLocator<GetChapters>()
        .call()
        .firstWhere((chapter) => chapter.id == _level.chapterId);
    // save progress and check if rating needs to be updated
    _previousRating = _level.rating;
    _previousCompleteRatio = _chapter.completedRatio;
    if (_newRating > _previousRating) {
      serviceLocator<CompleteLevel>().call(
        _level.copyWith(moves: _moves),
      );
    }

    _state = _state.copyWith(
      levelId: _levelId,
      nextLevelId: _nextLevelId,
      moves: _moves,
      rating: _newRating,
      bestResult: _level.bestResult,
      isSingleFlipAdded: _isSingleFlipAdded,
      isSolutionAdded: _isSolutionAdded,
      isNewChapterOpened: _isNewChapterOpened,
      isEndChapter: _isEndChapter,
      isEndGame: _isEndGame,
    );
  }

  String get _nextLevelId {
    int index = _chapter.levels.indexWhere((level) => level.id == _levelId);
    if (_chapter.levels.length > index + 1) {
      return _chapter.levels[index + 1].id;
    } else {
      return '';
    }
  }

  int get _newRating {
    if (_moves <= _level.bestResult) return 3;
    if (_moves <= _level.goodResult) return 2;
    return 1;
  }

  bool get _isSingleFlipAdded {
    if (_previousRating < 3 && _newRating == 3) {
      serviceLocator<SingleFlipsIncrement>().call();
      return true;
    } else {
      return false;
    }
  }

  bool get _isSolutionAdded {
    _chapter = _chapter.copyWith(
        levels: serviceLocator<GetChapters>()
            .call()
            .firstWhere((chapter) => chapter.id == _level.chapterId)
            .levels);
    if (_previousRating == 0 && _chapter.completedRatio == 1) {
      serviceLocator<SolutionsNumberIncrement>().call();
      return true;
    } else {
      return false;
    }
  }

  bool get _isNewChapterOpened {
    _chapter = _chapter.copyWith(
        levels: serviceLocator<GetChapters>()
            .call()
            .firstWhere((chapter) => chapter.id == _level.chapterId)
            .levels);
    if (_previousCompleteRatio < DefaultGameSettings.chapterCompleteRatio &&
        _chapter.completedRatio >= DefaultGameSettings.chapterCompleteRatio) {
      return true;
    } else {
      return false;
    }
  }

  bool get _isEndChapter {
    int index = _chapter.levels.indexWhere((level) => level.id == _levelId);
    if (_chapter.levels.length == index + 1) {
      return true;
    } else {
      return false;
    }
  }

  bool get _isEndGame {
    if (serviceLocator<GetLevels>().call().any((level) => level.moves == 0)) {
      return false;
    } else {
      return true;
    }
  }
}
