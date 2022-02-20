import 'dart:math';
import 'dart:async';

import 'package:flutter/material.dart';

import 'package:darkit/core/constants/default_game_settings.dart';
import 'package:darkit/internal/service_locator.dart';
import 'package:darkit/domain/hints/usecases/single_flips_decrement.dart';
import 'package:darkit/domain/hints/usecases/solutions_number_decrement.dart';
import 'package:darkit/domain/levels/entities/level_entity.dart';
import 'package:darkit/domain/levels/entities/cell_entity.dart';
import 'package:darkit/domain/levels/entities/chapter_entity.dart';
import 'package:darkit/domain/levels/usecases/get_chapers.dart';
import 'package:darkit/domain/levels/usecases/get_levels.dart';
import 'package:darkit/domain/hints/repositories/hints_repository.dart';
import 'package:darkit/presentation/game/view_model/view_model_state.dart';

class GameViewModel extends ChangeNotifier {
  GameViewModelState _state = GameViewModelState();

  GameViewModelState get state => _state;

  String _levelId;
  bool _isInit = true;
  int _moves = 0;
  late ChapterEntity _chapter;
  late LevelEntity _level;
  late List<bool> _currentCells;
  bool canTap = true;

  GameViewModel(this._levelId) {
    _init();
  }

  void _init() {
    _level = serviceLocator<GetLevels>()
        .call()
        .firstWhere((level) => level.id == _levelId);
    _chapter = serviceLocator<GetChapters>()
        .call()
        .firstWhere((chapter) => chapter.id == _level.chapterId);
    _moves = 0;
    _state = _state.copyWith(
      levelId: _levelId,
      levelNumber: (_levelNumber + 1).toString(),
      moves: _moves.toString(),
      singleFlips: _singleFlipsNumber.toString(),
      canUseSingleFlips: _canUseSingleFlips,
      isSingleFlipOn: false,
      solutionsNumber: _solutionsNumber.toString(),
      canUseSolution: _canUseSolution,
      isSolutionOn: false,
      fieldLength: sqrt(_cells.length).toInt(),
      cells: _cells,
      cellsToFlip: List<bool>.generate(_cells.length, (index) => false),
    );
  }

// -------- PUBLIC --------//

  void newInstance(String newLevelId) {
    int levelFieldLength = sqrt(_cells.length).toInt();
    _levelId = newLevelId;
    _init();
    int newLevelFieldLength = sqrt(_level.cells.length).toInt();
    List<bool> cellsToFlip = levelFieldLength == newLevelFieldLength
        // если предыдущий и следующий уровни одинаковой размерности
        ? _cellsToFlipToReset()
        // если предыдущий и следующий уровни разной размерности
        : List<bool>.generate(
            newLevelFieldLength * newLevelFieldLength, (index) => false);
    _isInit = true;
    _state = _state.copyWith(
      fieldLength: newLevelFieldLength,
      cells: _cells,
      cellsToFlip: cellsToFlip,
      canUseSingleFlips: _canUseSingleFlips,
      canUseSolution: _canUseSolution,
    );
    notifyListeners();
  }

  void useSolution() {
    // блокируем кнопки
    _state = _state.copyWith(
      isSolutionOn: true,
      canUseSingleFlips: false,
      canUseSolution: false,
    );
    // обнуляем поле
    List<bool> cellsToFlip =
        List<bool>.generate(_currentCells.length, (index) => false);
    for (int i = 0; i < _currentCells.length; i++) {
      if (_currentCells[i] !=
          [..._level.cells].map((cell) => cell.isBlack).toList()[i]) {
        cellsToFlip[i] = true;
      }
    }
    _solutionsDecrement();
    _moves = 0;
    int flashCellIndex = _cellIndexByCoordinates(
      _level.solution[_moves].x,
      _level.solution[_moves].y,
    );
    _isInit = true;
    _state = _state.copyWith(
      moves: _moves.toString(),
      cellsToFlip: cellsToFlip,
      cells: _cells,
      flashCellIndex: flashCellIndex,
      solutionsNumber: _solutionsNumber.toString(),
    );
    notifyListeners();
  }

  void useSingleFlip() {
    _state = _state.copyWith(
      isSingleFlipOn: !_state.isSingleFlipOn,
    );
    _state = _state.copyWith(
      canUseSolution: _canUseSolution,
    );
    notifyListeners();
  }

  void restartLevel() {
    List<bool> cellsToFlip = _cellsToFlipToReset();
    _moves = 0;
    _isInit = true;
    _state = _state.copyWith(
      moves: _moves.toString(),
      cellsToFlip: cellsToFlip,
      cells: _cells,
      isSingleFlipOn: false,
      isSolutionOn: false,
    );
    notifyListeners();
  }

  void flipCard(int index) {
    if (canTap) {
      if (_state.isSingleFlipOn) {
        // поворот одной ячейки
        _moves++;
        List<bool> cellsToFlip = _singleFlip(index);
        _state = _state.copyWith(
          moves: _moves.toString(),
          singleFlips: _singleFlipsNumber.toString(),
          cells: _cells,
          cellsToFlip: cellsToFlip,
          isSingleFlipOn: false,
        );
        notifyListeners();
        _blockCells();
      } else if (_state.isSolutionOn && index == _state.flashCellIndex) {
        // поворот в режиме решения
        _moves++;
        List<bool> cellsToFlip = _normalFlip(index);
        _state = _state.copyWith(
          moves: _moves.toString(),
          cells: _cells,
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
        _moves++;
        List<bool> cellsToFlip = _normalFlip(index);
        _state = _state.copyWith(
          moves: _moves.toString(),
          cells: _cells,
          cellsToFlip: cellsToFlip,
        );
        notifyListeners();
        _blockCells();
      }
    }
    Timer(const Duration(milliseconds: DefaultGameSettings.flipSpeed + 10), () {
      if (!_cells.contains(false)) {
        _state = _state.copyWith(isWin: true);
        notifyListeners();
      }
    });
  }

// -------- NON PUBLIC --------//

  List<bool> _cellsToFlipToReset() {
    List<bool> cellsToFlip =
        List<bool>.generate(_currentCells.length, (index) => false);
    for (int i = 0; i < _currentCells.length; i++) {
      if (_currentCells[i] !=
          [..._level.cells].map((cell) => cell.isBlack).toList()[i]) {
        cellsToFlip[i] = true;
      }
    }
    return cellsToFlip;
  }

  List<bool> get _cells {
    if (_isInit) {
      _currentCells = [..._level.cells].map((cell) => cell.isBlack).toList();
      _isInit = false;
    }
    return _currentCells;
  }

  int get _levelNumber {
    return _chapter.levelIndex(_levelId);
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

  List<bool> _singleFlip(int index) {
    List<bool> cellsToFlip =
        List<bool>.generate(_cells.length, (index) => false);
    _cells[index] = !_cells[index];
    cellsToFlip[index] = true;
    _singleFlipsDecrement();
    return cellsToFlip;
  }

  List<bool> _normalFlip(int index) {
    List<bool> cellsToFlip =
        List<bool>.generate(_cells.length, (index) => false);
    int x = _level.cells[index].x;
    int y = _level.cells[index].y;
    _cells[index] = !_cells[index];
    cellsToFlip[index] = true;
    try {
      _cells[_cellIndexByCoordinates(x, y - 1)] =
          !_cells[_cellIndexByCoordinates(x, y - 1)];
      cellsToFlip[_cellIndexByCoordinates(x, y - 1)] = true;
    } catch (error) {}
    try {
      _cells[_cellIndexByCoordinates(x, y + 1)] =
          !_cells[_cellIndexByCoordinates(x, y + 1)];
      cellsToFlip[_cellIndexByCoordinates(x, y + 1)] = true;
    } catch (error) {}
    try {
      _cells[_cellIndexByCoordinates(x - 1, y)] =
          !_cells[_cellIndexByCoordinates(x - 1, y)];
      cellsToFlip[_cellIndexByCoordinates(x - 1, y)] = true;
    } catch (error) {}
    try {
      _cells[_cellIndexByCoordinates(x + 1, y)] =
          !_cells[_cellIndexByCoordinates(x + 1, y)];
      cellsToFlip[_cellIndexByCoordinates(x + 1, y)] = true;
    } catch (error) {}
    return cellsToFlip;
  }

  void _blockCells() {
    canTap = false;
    Timer(const Duration(milliseconds: DefaultGameSettings.flipSpeed + 10), () {
      canTap = true;
    });
  }
}
