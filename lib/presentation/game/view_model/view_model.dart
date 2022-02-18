import 'dart:async';
import 'dart:math';

import 'package:darkit/core/constants/default_game_settings.dart';
import 'package:darkit/domain/hints/usecases/single_flips_decrement.dart';
import 'package:darkit/domain/levels/entities/level_entity.dart';
import 'package:flutter/material.dart';

import 'package:darkit/internal/service_locator.dart';
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
      levelNumber: (_levelNumber + 1).toString(),
      moves: _moves.toString(),
      singleFlips: _singleFlipsNumber.toString(),
      canUseSingleFlips: _canUseSingleFlips,
      isSingleFlipOn: _isSingleFlipOn,
      solutionsNumber: _solutionsNumber.toString(),
      canUseSolution: _canUseSolution,
      fieldLength: sqrt(_cells.length).toInt(),
      cells: _cells,
      cellsToFlip: List<bool>.generate(_cells.length, (index) => false),
    );
  }

  // void _updateState() {
  //   // _init(); // !
  //   notifyListeners(); // !
  // }

  int get _levelNumber {
    return _chapter.levelIndex(_levelId);
  }

  int get _singleFlipsNumber {
    return serviceLocator<HintsRepository>().hints.singleFlips;
  }

  Future<void> _singleFlipsDecrement() async {
    await serviceLocator<SingleFlipsDecrement>().call();
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

  List<bool> get _cells {
    if (_isInit) {
      _currentCells = [..._level.cells].map((cell) => cell.isBlack).toList();
      _isInit = false;
    }
    return _currentCells;
  }

  void useSingleFlip() {
    // !
  }

  void restartLevel() {
    List<bool> cellsToFlip =
        List<bool>.generate(_currentCells.length, (index) => false);
    for (int i = 0; i < _currentCells.length; i++) {
      if (_currentCells[i] !=
          [..._level.cells].map((cell) => cell.isBlack).toList()[i]) {
        cellsToFlip[i] = true;
      }
    }
    _moves = 0;
    _isInit = true;
    _state = _state.copyWith(
      moves: _moves.toString(),
      fieldLength: sqrt(_cells.length).toInt(),
      cellsToFlip: cellsToFlip,
      cells: _cells,
    );
    notifyListeners();
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

  int _cellIndexByCoordinates(int x, int y) {
    CellEntity _cell =
        _level.cells.firstWhere((cell) => cell.x == x && cell.y == y);
    return _level.cells.indexOf(_cell);
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

  void flipCard(int index) {
    if (canTap) {
      _moves++;
      var tempCells = _normalFlip(index);

      _state = _state.copyWith(
        moves: _moves.toString(),
        cells: _cells,
        cellsToFlip: tempCells,
      );
      print('1: ${_cells[0]} - ${_cells[1]} - ${_cells[2]}');
      print('2: ${_cells[3]} - ${_cells[4]} - ${_cells[5]}');
      print('3: ${_cells[6]} - ${_cells[7]} - ${_cells[8]}');
      notifyListeners();
      canTap = false;
      Timer(const Duration(milliseconds: DefaultGameSettings.flipSpeed + 10),
          () {
        canTap = true;
      });
    }

    // ! тут решаем какой делать флип - всех ячеек: одной ячейки, этой ячейки и соседних, не делать флип
    // !
  }
}


// ! TODO if(!_cells.contains(false)) WIN!!!!