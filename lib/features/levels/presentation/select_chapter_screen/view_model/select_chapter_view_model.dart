import 'package:darkit/features/hints/domain/usecases/reset_hints.dart';
import 'package:darkit/features/levels/domain/entities/chapter_entity.dart';
import 'package:darkit/features/levels/domain/usecases/genereate_chapers.dart';
import 'package:darkit/features/levels/domain/usecases/reset_levels.dart';
import 'package:darkit/internal/service_locator.dart';
import 'package:flutter/material.dart';

class SelectChapterViewModel extends ChangeNotifier {
  bool _loading = false;
  final List<ChapterEntity> _chapters =
      serviceLocator<GenerateChapters>().call();

  List<String> get chapters {
    return _chapters.map((chapter) => chapter.levels.first.chapterId).toList();
  }

  ChapterEntity _chapter(String chapterId) {
    return _chapters.firstWhere((chapter) => chapter.id == chapterId);
  }

  int get chaptersNumber => chapters.length;

  double completedRatio(String chapterId) {
    return _chapter(chapterId).completedRatio;
  }

  String completedLevels(String chapterId) {
    return _chapter(chapterId).completedLevelsNumber.toString();
  }

  String levelsNumber(String chapterId) {
    return _chapter(chapterId).levelsNumber.toString();
  }

  bool canBePlayed(String chapterId) {
    final _chapterIndex = _chapters.indexOf(_chapter(chapterId));
    if (_chapterIndex == 0) return true; // если это первая глава
    return _chapters[_chapterIndex - 1].completedRatio >
        0.7; // если предыдущая глава пройдена не менее чем на 70%
  }

  Future<void> reset() async {
    await serviceLocator<ResetLevels>().call();
    await serviceLocator<ResetHints>().call();
    _updateView();
  }

  void update() {
    _updateView();
  }

  void _updateView() {
    _chapters.clear();
    _chapters.addAll(serviceLocator<GenerateChapters>().call());
    notifyListeners();
  }

  // void _updateState() {
  //   final List<ChapterEntity> _chapters =
  //     serviceLocator<GenerateChapters>().call();
  //   _state = SelectChapterViewModelState(
  //     chapters: chapters,

  //   );
  //   notifyListeners();
  // }
}
