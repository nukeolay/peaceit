import 'package:darkit/domain/levels/entities/chapter_entity.dart';
import 'package:darkit/domain/levels/usecases/complete_level.dart';
import 'package:darkit/domain/levels/usecases/get_chapers.dart';
import 'package:flutter/material.dart';

import 'package:darkit/internal/service_locator.dart';
import 'package:darkit/domain/levels/entities/level_entity.dart';
import 'package:darkit/domain/levels/usecases/get_levels.dart';
import 'package:darkit/presentation/level_completed/view_model/view_model_state.dart';

class LevelCompletedViewModel extends ChangeNotifier {
  LevelCompletedViewModelState _state = LevelCompletedViewModelState();

  LevelCompletedViewModelState get state => _state;

  final String _levelId;
  final int _moves;
  late final LevelEntity _level;
  late final ChapterEntity _chapter;

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
    // ! сохранить прогресс, проверив нужно и обновить рейтинг
    if (_rating > _level.rating) {
      serviceLocator<CompleteLevel>().call(
        _level.copyWith(rating: _rating),
      );
    }

    _state = _state.copyWith(
      levelId: _levelId,
      nextLevelId: _nextLevelId,
      moves: _moves,
      rating: _rating,
      bestResult: _level.bestResult,
      isSingleFlipAdded: _isSingleFlipAdded,
      isSolutionAdded: _isSolutionAdded,
      isNewChapterOpened: _isNewChapterOpened,
      isEndGame: _isEndGame,
    );
  }

  String get _nextLevelId {
    int index = _chapter.levels.indexWhere((level) => level.id == _levelId);
    return _chapter.levels[index + 1]
        .id; // ! предусмотреть что это может быть послежний уровень в главе, игре
  }

  int get _rating {
    _level.bestResult;
    if (_moves <= _level.bestResult) return 3;
    if (_moves <= _level.goodResult) return 2;
    return 1;
  }

  bool get _isSingleFlipAdded {
    return false; // !
  }

  bool get _isSolutionAdded {
    return false; // !
  }

  bool get _isNewChapterOpened {
    return false; // !
  }

  bool get _isEndGame {
    return false; // !
  }
}
