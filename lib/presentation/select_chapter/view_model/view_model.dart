import 'package:flutter/material.dart';

import 'package:peaceit/core/constants/default_game_settings.dart';
import 'package:peaceit/internal/service_locator.dart';
import 'package:peaceit/domain/hints/usecases/reset_hints.dart';
import 'package:peaceit/domain/levels/entities/chapter_entity.dart';
import 'package:peaceit/domain/levels/usecases/get_chapers.dart';
import 'package:peaceit/domain/levels/usecases/reset_levels.dart';
import 'package:peaceit/domain/tutorial/usecases/reset_tutorial.dart';
import 'package:peaceit/presentation/select_chapter/view_model/view_model_state.dart';

class SelectChapterViewModel extends ChangeNotifier {
  SelectChapterViewModelState _state = SelectChapterViewModelState();

  SelectChapterViewModelState get state => _state;

  SelectChapterViewModel() {
    _init();
  }

  final List<ChapterEntity> _chapters = [];

  void _init() {
    _chapters.clear();
    _chapters.addAll(serviceLocator<GetChapters>().call());
    _state = _state.copyWith(
      chapters: _chapterIds,
      chaptersNumber: _chaptersNumber,
      completedRatio: _completedRatio,
      completedLevels: _completedLevels,
      levelsNumber: _levelsNumber,
      canBePlayed: _canBePlayed,
    );
  }

  void _updateState() {
    _init();
    notifyListeners();
  }

  void update() {
    _updateState();
  }

  Future<void> reset() async {
    await serviceLocator<ResetTutorial>().call();
    await serviceLocator<ResetLevels>().call();
    await serviceLocator<ResetHints>().call();
    _updateState();
  }

  List<String> get _chapterIds {
    return _chapters.map((chapter) => chapter.levels.first.chapterId).toList();
  }

  int get _chaptersNumber => _chapterIds.length;

  List<double> get _completedRatio {
    return _chapters.map((chapter) => chapter.completedRatio).toList();
  }

  List<String> get _completedLevels {
    return _chapters
        .map((chapter) => chapter.completedLevelsNumber.toString())
        .toList();
  }

  List<String> get _levelsNumber {
    return _chapters.map((chapter) => chapter.levelsNumber.toString()).toList();
  }

  List<bool> get _canBePlayed {
    List<bool> result = [];
    for (ChapterEntity _chapter in _chapters) {
      int chapterIndex = _chapters.indexOf(_chapter);
      if (chapterIndex == 0) {
        result.add(true); // if this is first chapter
      } else {
        // if previous chapter completed more than 70% (DefaultGameSettings.chapterCompleteRatio)
        result.add(_chapters[chapterIndex - 1].completedRatio >=
            DefaultGameSettings.chapterCompleteRatio);
      }
    }
    return result;
  }
}
