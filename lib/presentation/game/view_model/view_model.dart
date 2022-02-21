import 'dart:math';
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:darkit/core/constants/default_game_settings.dart';
import 'package:darkit/internal/service_locator.dart';
import 'package:darkit/domain/hints/usecases/single_flips_decrement.dart';
import 'package:darkit/domain/hints/usecases/solutions_number_decrement.dart';
import 'package:darkit/domain/levels/entities/level_entity.dart';
import 'package:darkit/domain/levels/entities/cell_entity.dart';
import 'package:darkit/domain/levels/entities/chapter_entity.dart';
import 'package:darkit/domain/levels/usecases/get_chapers.dart';
import 'package:darkit/domain/hints/repositories/hints_repository.dart';
import 'package:darkit/presentation/game/view_model/view_model_state.dart';

class GameViewModel extends ChangeNotifier {
  late GameViewModelState _state;

  GameViewModelState get state => _state;

  bool _canTap = true;

  GameViewModel(String levelId) {
    _init(levelId);
  }

  void _init(String levelId) {
    ChapterEntity chapter = serviceLocator<GetChapters>().call().firstWhere(
        (chapter) => chapter.levels.any((level) => level.id == levelId));
    LevelEntity level =
        chapter.levels.firstWhere((level) => level.id == levelId);
    _state = GameViewModelState(
      chapter: chapter,
      levelId: levelId,
      levelNumber: (chapter.levelIndex(levelId) + 1).toString(),
      singleFlips: _singleFlipsNumber.toString(),
      canUseSingleFlips: _singleFlipsNumber > 0,
      solutionsNumber: _solutionsNumber.toString(),
      canUseSolution: _solutionsNumber > 0,
      fieldLength: sqrt(level.cells.length).toInt(),
      cells: [...level.cells].map((cell) => cell.isBlack).toList(),
      cellsToFlip: List<bool>.generate(level.cells.length, (index) => false),
    );
  }

// -------- PUBLIC --------//

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
    List<bool> cellsToFlip = _cellsToFlip(
      cells: _state.cells,
      newCells: _initCells,
    );
    _solutionsDecrement();
    int flashCellIndex = _cellIndexByCoordinates(
      _level.solution[_moves].x,
      _level.solution[_moves].y,
    );
    _state = _state.copyWith(
      moves: '0',
      cellsToFlip: cellsToFlip,
      isSolutionOn: true,
      canUseSingleFlips: false,
      canUseSolution: false,
      cells: _initCells,
      flashCellIndex: flashCellIndex,
      solutionsNumber: _solutionsNumber.toString(),
    );
    notifyListeners();
  }

  void useSingleFlip() {
    _state = _state.copyWith(
      isSingleFlipOn: !_state.isSingleFlipOn,
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
          int flashCellIndex = _cellIndexByCoordinates(
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
        _state = _state.copyWith(
          moves: (_moves + 1).toString(),
          cells: flippedCells,
          cellsToFlip: cellsToFlip,
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

  String get _levelId => _state.levelId;

  LevelEntity get _level {
    return _state.chapter.levels.firstWhere((level) => level.id == _levelId);
  }

  List<bool> get _initCells {
    LevelEntity level =
        _state.chapter.levels.firstWhere((level) => level.id == _state.levelId);
    return [...level.cells].map((cell) => cell.isBlack).toList();
  }

  List<bool> _cellsToFlip({
    required List<bool> cells,
    required List<bool> newCells,
  }) {
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
    return _solutionsNumber > 0 &&
        !_state.isSingleFlipOn &&
        !_state.isSolutionOn;
  }

  int _cellIndexByCoordinates(int x, int y) {
    CellEntity _cell =
        _level.cells.firstWhere((cell) => cell.x == x && cell.y == y);
    return _level.cells.indexOf(_cell);
  }

  List<bool> _singleFlip({
    required int index,
    required List<bool> cells,
  }) {
    List<bool> flippedCells = [...cells];
    flippedCells[index] = !flippedCells[index];
    return flippedCells;
  }

  List<bool> _normalFlip({
    required int index,
    required List<bool> cells,
  }) {
    List<bool> flippedCells = [...cells];
    int x = _level.cells[index].x;
    int y = _level.cells[index].y;
    flippedCells[index] = !flippedCells[index];
    try {
      index = _cellIndexByCoordinates(x, y - 1);
      flippedCells[index] = !flippedCells[index];
    } catch (error) {}
    try {
      index = _cellIndexByCoordinates(x, y + 1);
      flippedCells[index] = !flippedCells[index];
    } catch (error) {}
    try {
      index = _cellIndexByCoordinates(x - 1, y);
      flippedCells[index] = !flippedCells[index];
    } catch (error) {}
    try {
      index = _cellIndexByCoordinates(x + 1, y);
      flippedCells[index] = !flippedCells[index];
    } catch (error) {}
    return flippedCells;
  }

  void _blockCells() {
    _canTap = false;
    Timer(const Duration(milliseconds: DefaultGameSettings.flipSpeed + 10), () {
      _canTap = true;
    });
  }
}
