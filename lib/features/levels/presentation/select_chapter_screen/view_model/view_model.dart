import 'package:flutter/material.dart';

import 'package:darkit/internal/service_locator.dart';
import 'package:darkit/features/hints/domain/usecases/reset_hints.dart';
import 'package:darkit/features/levels/domain/entities/chapter_entity.dart';
import 'package:darkit/features/levels/domain/usecases/genereate_chapers.dart';
import 'package:darkit/features/levels/domain/usecases/reset_levels.dart';
import 'package:darkit/features/levels/presentation/select_chapter_screen/view_model/view_model_state.dart';

class SelectChapterViewModel extends ChangeNotifier {
  SelectChapterViewModelState _state = SelectChapterViewModelState();

  SelectChapterViewModelState get state => _state;

  SelectChapterViewModel() {
    _init();
  }

  final List<ChapterEntity> _chapters = [];

  void _init() {
    _chapters.clear();
    _chapters.addAll(serviceLocator<GenerateChapters>().call());
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
    final List<bool> _result = [];
    for (var _chapter in _chapters) {
      final _chapterIndex = _chapters.indexOf(_chapter);
      if (_chapterIndex == 0) {
        _result.add(true); // если это первая глава
      } else {
        // если предыдущая глава пройдена не менее чем на 70%
        _result.add(_chapters[_chapterIndex - 1].completedRatio > 0.7);
      }
    }
    return _result;
  }
}
