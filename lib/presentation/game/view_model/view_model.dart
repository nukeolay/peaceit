import 'package:darkit/domain/hints/repositories/hints_repository.dart';
import 'package:flutter/material.dart';

import 'package:darkit/domain/levels/entities/cell_entity.dart';
import 'package:darkit/domain/levels/entities/chapter_entity.dart';
import 'package:darkit/domain/levels/usecases/get_chapers.dart';
import 'package:darkit/domain/levels/usecases/get_levels.dart';
import 'package:darkit/internal/service_locator.dart';
import 'package:darkit/presentation/game/view_model/view_model_state.dart';

class GameViewModel extends ChangeNotifier {
  GameViewModelState _state = GameViewModelState();

  GameViewModelState get state => _state;

  String _levelId;
  late ChapterEntity _chapter;
  int _moves = 0;

  GameViewModel(this._levelId) {
    String chapterId = serviceLocator<GetLevels>()
        .call()
        .firstWhere((level) => level.id == _levelId)
        .chapterId;
    _chapter = serviceLocator<GetChapters>()
        .call()
        .firstWhere((chapter) => chapter.id == chapterId);
    _init();
  }

  void _init() {
    _moves = 0;
    _state = _state.copyWith(
      levelNumber: _levelNumber.toString(),
      moves: _moves.toString(),
      singleFlips: _singleFlipsNumber.toString(),
      canUseSingleFlips: _canUseSingleFlips,
      isSingleFlipOn: _isSingleFlipOn,
      solutionsNumber: _solutionsNumber.toString(),
      canUseSolution: _canUseSolution,
      cells: _cells,
    );
  }

  void _updateState() {
    // _init(); // !
    notifyListeners(); // !
  }

  int get _levelNumber {
    return _chapter.levelIndex(_levelId) + 1;
  }

  int get _singleFlipsNumber {
    return serviceLocator<HintsRepository>().hints.singleFlips;
  }

  bool get _canUseSingleFlips {
    // return singleFlips != 0 && gameField.solutionCell == null; не включен режим решения
    return _singleFlipsNumber > 0;
  }

  bool get _isSingleFlipOn {
    return false; // !
  }

  int get _solutionsNumber {
    return serviceLocator<HintsRepository>().hints.solutionsNumber;
  }

  bool get _canUseSolution {
    // return singleFlips != 0 && gameField.solutionCell == null; не включен режим решения
    return _solutionsNumber > 0;
  }

  List<CellEntity> get _cells {
    return _chapter.levels[_levelNumber].cells;
  }

  void useSingleFlip() {
    // !
  }

  void update() {
    _updateState();
  }

  void restartLevel() {
    _init();
  }

  void useSolution() {
    // !
  }

  void nextLevel() {
    // TODO проработать на случай последнего уровня в главе
    _levelId = _chapter.levels[_levelNumber + 1].id;
    _init();
    notifyListeners();
  }
}
