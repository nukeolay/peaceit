import 'dart:math';
import 'dart:async';

import 'package:peaceit/domain/hints/usecases/update_hints.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:peaceit/core/constants/default_game_settings.dart';
import 'package:peaceit/internal/service_locator.dart';
import 'package:peaceit/domain/levels/usecases/normal_flip.dart';
import 'package:peaceit/domain/levels/usecases/single_flip.dart';
import 'package:peaceit/domain/hints/usecases/single_flips_decrement.dart';
import 'package:peaceit/domain/hints/usecases/solutions_number_decrement.dart';
import 'package:peaceit/domain/levels/entities/level_entity.dart';
import 'package:peaceit/domain/levels/entities/chapter_entity.dart';
import 'package:peaceit/domain/levels/usecases/get_chapers.dart';
import 'package:peaceit/domain/hints/repositories/hints_repository.dart';
import 'package:peaceit/domain/tutorial/usecases/get_tutorial.dart';
import 'package:peaceit/domain/tutorial/usecases/update_tutorial.dart';
import 'package:peaceit/domain/tutorial/entities/tutorial_entity.dart';
import 'package:peaceit/presentation/game/view_model/view_model_state.dart';

class GameViewModel extends ChangeNotifier {
  late GameViewModelState _state;

  GameViewModelState get state => _state;

  bool _canTap = true;

  GameViewModel(String levelId) {
    _init(levelId);
  }

  void _init(String levelId) {
    TutorialEntity tutorial = serviceLocator<GetTutorial>().call();
    ChapterEntity chapter = serviceLocator<GetChapters>().call().firstWhere(
        (chapter) => chapter.levels.any((level) => level.id == levelId));
    LevelEntity level =
        chapter.levels.firstWhere((level) => level.id == levelId);
    _state = GameViewModelState(
      chapter: chapter,
      levelId: levelId,
      isBoss: chapter.levels.length == chapter.levelIndex(levelId) + 1,
      levelNumber: (chapter.levelIndex(levelId) + 1).toString(),
      singleFlips: _singleFlipsNumber.toString(),
      canUseSingleFlips: _singleFlipsNumber > 0,
      solutionsNumber: _solutionsNumber.toString(),
      canUseSolution: _solutionsNumber > 0,
      showTutorialIntro: !tutorial.intro,
      flashSingleFlips: false,
      flashSolutions: false,
      isTutorialIntroShown: tutorial.intro,
      isTutorialSingleFlipsShown: tutorial.singleFlips,
      isTutorialSolutionsShown: tutorial.solutions,
      fieldLength: sqrt(level.cells.length).toInt(),
      cells: [...level.cells].map((cell) => cell.isPeace).toList(),
      cellsToFlip: List<bool>.generate(level.cells.length, (index) => false),
    );
  }

// -------- PUBLIC --------//

  void closeIntroTutorialDialog() {
    _state = _state.copyWith(showTutorialIntro: false);
    serviceLocator<UpdateTutorial>().call(intro: true);
    notifyListeners();
  }

  void closeSingleFlipTutorialDialog() async {
    // если SingleFlips уже нет, а подсказку нужно показать, то добавить 1 SingleFlip
    int lightCellsNumber = _state.cells
        .map((cell) => cell ? 0 : 1)
        .reduce((value, element) => value + element);
    if (_singleFlipsNumber < lightCellsNumber) {
      await serviceLocator<UpdateHints>().call(singleFlips: 3);
    }
    _state = _state.copyWith(
      isTutorialSingleFlipsShown: true,
      showTutorialSingleFlips: false,
      singleFlips: _singleFlipsNumber.toString(),
      canUseSingleFlips: _canUseSingleFlips,
    );
    serviceLocator<UpdateTutorial>().call(singleFlips: true);
    notifyListeners();
  }

  void closeSolutionTutorialDialog() async {
    // если solutions уже нет, а подсказку нужно показать, то добавить 1 solution
    if (_solutionsNumber == 0) {
      await serviceLocator<UpdateHints>().call(solutionsNumber: 1);
    }
    _state = _state.copyWith(
      isTutorialSolutionsShown: true,
      showTutorialSolutions: false,
      solutionsNumber: _solutionsNumber.toString(),
      canUseSolution: _canUseSolution,
    );
    serviceLocator<UpdateTutorial>().call(solutions: true);
    notifyListeners();
  }

  void newInstance(String newLevelId) {
    int previousFieldLength = sqrt(_state.cells.length).toInt();
    List<bool> previousCells = _state.cells;
    _init(newLevelId);
    int newFieldLength = sqrt(_level.cells.length).toInt();
    List<bool> cellsToFlip = previousFieldLength == newFieldLength
        // если предыдущий и следующий уровни одинаковой размерности
        ? _cellsToFlip(
            cells: previousCells,
            newCells: _initCells,
          )
        // если предыдущий и следующий уровни разной размерности
        : List<bool>.generate(
            newFieldLength * newFieldLength, (index) => false);
    _state = _state.copyWith(
      fieldLength: newFieldLength,
      cellsToFlip: cellsToFlip,
      canUseSingleFlips: _canUseSingleFlips,
      canUseSolution: _canUseSolution,
    );
    notifyListeners();
  }

  void useSolution() {
    _solutionsDecrement();
    List<bool> cellsToFlip = _cellsToFlip(
      cells: _state.cells,
      newCells: _initCells,
    );
    int flashCellIndex = _level.cellIndexByCoordinates(
      _level.solution[0].x,
      _level.solution[0].y,
    );
    _state = _state.copyWith(
      moves: '0',
      cellsToFlip: cellsToFlip,
      cells: _initCells,
      isSolutionOn: true,
      isSingleFlipOn: false,
      canUseSingleFlips: false,
      canUseSolution: false,
      flashCellIndex: flashCellIndex,
      solutionsNumber: _solutionsNumber.toString(),
    );
    notifyListeners();
  }

  void useSingleFlip() {
    _state = _state.copyWith(
      isSingleFlipOn: !_state.isSingleFlipOn,
      // canUseSolution: _canUseSolution,
    );
    _state = _state.copyWith(
      // isSingleFlipOn: !_state.isSingleFlipOn,
      canUseSolution: _canUseSolution,
    );
    notifyListeners();
  }

  void restartLevel() {
    List<bool> cellsToFlip = _cellsToFlip(
      cells: _state.cells,
      newCells: _initCells,
    );
    _state = _state.copyWith(
      moves: '0',
      cellsToFlip: cellsToFlip,
      cells: _initCells,
      isSingleFlipOn: false,
      isSolutionOn: false,
    );
    notifyListeners();
  }

  void flipCard(int index) {
    if (_canTap) {
      HapticFeedback.heavyImpact();
      if (_state.isSingleFlipOn) {
        // поворот одной ячейки
        _singleFlipsDecrement();
        List<bool> flippedCells = _singleFlip(
          index: index,
          cells: _state.cells,
        );
        List<bool> cellsToFlip = _cellsToFlip(
          cells: _state.cells,
          newCells: flippedCells,
        );
        _state = _state.copyWith(
          moves: (_moves + 1).toString(),
          singleFlips: _singleFlipsNumber.toString(),
          cells: flippedCells,
          cellsToFlip: cellsToFlip,
          isSingleFlipOn: false,
          canUseSingleFlips: _canUseSingleFlips,
          canUseSolution: _canUseSolution,
        );
        notifyListeners();
        _blockCells();
      } else if (_state.isSolutionOn && index == _state.flashCellIndex) {
        // поворот в режиме решения
        List<bool> flippedCells = _normalFlip(
          index: index,
          cells: _state.cells,
        );
        List<bool> cellsToFlip = _cellsToFlip(
          cells: _state.cells,
          newCells: flippedCells,
        );
        _state = _state.copyWith(
          moves: (_moves + 1).toString(),
          cells: flippedCells,
          cellsToFlip: cellsToFlip,
        );
        if (_level.solution.length - 1 >= _moves) {
          // если еще остались решения
          int flashCellIndex = _level.cellIndexByCoordinates(
            _level.solution[_moves].x,
            _level.solution[_moves].y,
          );
          _state = _state.copyWith(
            cellsToFlip: cellsToFlip,
            flashCellIndex: flashCellIndex,
          );
        }
        notifyListeners();
        _blockCells();
      } else if (_state.isSolutionOn) {
        // если нажать не на ту ячейку в режиме решения
      } else {
        // обычный поворот вместе с соседними ячейками
        List<bool> flippedCells = _normalFlip(
          index: index,
          cells: _state.cells,
        );
        List<bool> cellsToFlip = _cellsToFlip(
          cells: _state.cells,
          newCells: flippedCells,
        );
        bool showTutorialSolutions = false;
        bool showTutorialSingleFlips = false;
        bool flashSolutions = false;
        bool flashSingleFlips = false;
        int lightCellsNumber = flippedCells
            .map((cell) => cell ? 0 : 1)
            .reduce((value, element) => value + element);
        // если четыре флипа то показать подсказку по решению при уловии что после этого флипа уровень не пройден
        if (!_state.isBoss &&
            _moves == 3 &&
            !_state.isTutorialSolutionsShown &&
            lightCellsNumber != 0) {
          showTutorialSolutions = true;
          flashSolutions = true;
        }
        // если solution уже был показан и количество светлых ячеек 3, 2 или 1 и эта подсказка еще не была показана, то показать подсказку по флипам
        if (!_state.isBoss &&
            lightCellsNumber <= 3 &&
            lightCellsNumber != 0 &&
            _state.isTutorialSolutionsShown &&
            !_state.isTutorialSingleFlipsShown) {
          showTutorialSingleFlips = true;
          flashSingleFlips = true;
        }
        _state = _state.copyWith(
          moves: (_moves + 1).toString(),
          cells: flippedCells,
          cellsToFlip: cellsToFlip,
          showTutorialSolutions: showTutorialSolutions,
          showTutorialSingleFlips: showTutorialSingleFlips,
          flashSingleFlips: flashSingleFlips,
          flashSolutions: flashSolutions,
        );
        notifyListeners();
        _blockCells();
      }
    }
    Timer(const Duration(milliseconds: DefaultGameSettings.flipSpeed + 10), () {
      if (!_state.cells.contains(false)) {
        _state = _state.copyWith(isWin: true);
        notifyListeners();
      }
    });
  }

// -------- NON PUBLIC --------//

  int get _moves {
    return int.parse(_state.moves);
  }

  LevelEntity get _level {
    return _state.chapter.levels
        .firstWhere((level) => level.id == _state.levelId);
  }

  List<bool> get _initCells {
    LevelEntity level =
        _state.chapter.levels.firstWhere((level) => level.id == _state.levelId);
    return level.boolCells;
  }

  List<bool> _cellsToFlip(
      {required List<bool> cells, required List<bool> newCells}) {
    List<bool> cellsToFlip =
        List<bool>.generate(cells.length, (index) => false);
    for (int i = 0; i < cells.length; i++) {
      if (cells[i] != newCells[i]) {
        cellsToFlip[i] = true;
      }
    }
    return cellsToFlip;
  }

  int get _singleFlipsNumber {
    return serviceLocator<HintsRepository>().hints.singleFlips;
  }

  Future<void> _singleFlipsDecrement() async {
    await serviceLocator<SingleFlipsDecrement>().call();
  }

  Future<void> _solutionsDecrement() async {
    await serviceLocator<SolutionsNumberDecrement>().call();
  }

  bool get _canUseSingleFlips {
    return _singleFlipsNumber > 0 && !_state.isSolutionOn;
  }

  int get _solutionsNumber {
    return serviceLocator<HintsRepository>().hints.solutionsNumber;
  }

  bool get _canUseSolution {
    return _solutionsNumber > 0 && !_state.isSolutionOn;
  }

  List<bool> _singleFlip({required int index, required List<bool> cells}) {
    return SingleFlip(index: index, level: _level.copyWithBools(cells: cells))
        .call()
        .boolCells;
  }

  List<bool> _normalFlip({required int index, required List<bool> cells}) {
    return NormalFlip(index: index, level: _level.copyWithBools(cells: cells))
        .call()
        .boolCells;
  }

  void _blockCells() {
    _canTap = false;
    Timer(
        const Duration(
          milliseconds:
              DefaultGameSettings.flipSpeed + DefaultGameSettings.blockPeriod,
        ), () {
      _canTap = true;
    });
  }
}
