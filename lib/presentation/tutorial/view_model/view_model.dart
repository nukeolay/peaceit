import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:darkit/core/constants/default_game_settings.dart';
import 'package:darkit/domain/levels/entities/level_entity.dart';
import 'package:darkit/domain/levels/usecases/normal_flip.dart';
import 'package:darkit/domain/levels/usecases/single_flip.dart';
import 'package:darkit/presentation/tutorial/view_model/view_model_state.dart';
import 'package:darkit/presentation/tutorial/view_model/tutorial_levels.dart';

class TutorialViewModel extends ChangeNotifier {
  late TutorialViewModelState _state;

  TutorialViewModelState get state => _state;

  TutorialViewModel(String levelId) {
    _init(levelId);
  }

  bool _canTap = true;

  void _init(String levelId) {
    LevelEntity level =
        TutorialLevels.levels.firstWhere((level) => level.id == levelId);
    _state = TutorialViewModelState(
      levelId: levelId,
      levelNumber: '1',
      singleFlips: '0',
      canUseSingleFlips: false,
      solutionsNumber: '0',
      canUseSolution: false,
      fieldLength: sqrt(level.cells.length).toInt(),
      cells: [...level.cells].map((cell) => cell.isBlack).toList(),
      cellsToFlip: List<bool>.generate(level.cells.length, (index) => false),
    );
  }

// -------- PUBLIC --------//

  void newInstance(String newLevelId) {
    // ! TODO прописать условия на случай открытия первого или второго уровня.
    int levelNumber = int.parse(_state.levelNumber);
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
      showIntroTutoriaDialog: false,
      levelNumber: (levelNumber + 1).toString(),
      fieldLength: newFieldLength,
      cellsToFlip: cellsToFlip,
      canUseSingleFlips: _canUseSingleFlips,
      canUseSolution: _canUseSolution,
    );
    if (newLevelId == 'tut6x6n3') {
      _state = _state.copyWith(
        cellsToFlip: _state.cellsToFlip,
        solutionUsed: true,
        nextLevelId: _state.nextLevelId,
      );
    }
    notifyListeners();
  }

  void closeIntroTutorialDialog() {
    _state = _state.copyWith(showIntroTutoriaDialog: false);
    notifyListeners();
  }

  void closeSolutionTutorialDialog() {
    _state = _state.copyWith(showSolutionTutoriaDialog: false);
    notifyListeners();
  }

  void closeSingleFlipTutorialDialog() {
    _state = _state.copyWith(showSingleFlipTutoriaDialog: false);
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
      solutionUsed: true,
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
      canUseSolution: _canUseSolution,
    );
    notifyListeners();
  }

  void restartLevel() {
    List<bool> cellsToFlip = _cellsToFlip(
      cells: _state.cells,
      newCells: _initCells,
    );
    if (_state.levelId == 'tut6x6n3') {
      _state = _state.copyWith(
        moves: '0',
        cellsToFlip: cellsToFlip,
        cells: _initCells,
        singleFlips: '0',
        canUseSingleFlips: false,
        showSingleFlipTutoriaDialog: false,
      );
    } else {
      _state = _state.copyWith(
        moves: '0',
        cellsToFlip: cellsToFlip,
        cells: _initCells,
        isSingleFlipOn: false,
        isSolutionOn: false,
      );
    }
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
        if (_moves == 3 && !_state.solutionUsed) {
          _state = _state.copyWith(
            moves: (_moves + 1).toString(),
            cells: flippedCells,
            cellsToFlip: cellsToFlip,
            solutionsNumber: '1',
            canUseSolution: true,
            showSolutionTutoriaDialog: true,
          );
        } else if (_moves == 2 && _state.solutionUsed) {
          _state = _state.copyWith(
            moves: (_moves + 1).toString(),
            cells: flippedCells,
            cellsToFlip: cellsToFlip,
            singleFlips: '50',
            canUseSingleFlips: true,
            showSingleFlipTutoriaDialog: true,
          );
        } else {
          _state = _state.copyWith(
            moves: (_moves + 1).toString(),
            cells: flippedCells,
            cellsToFlip: cellsToFlip,
            canUseSingleFlips: _canUseSingleFlips,
          );
        }
        notifyListeners();
        _blockCells();
      }
    }
    Timer(const Duration(milliseconds: DefaultGameSettings.flipSpeed + 10), () {
      if (!_state.cells.contains(false)) {
        if (_state.levelId == 'tut6x6n1' && !state.solutionUsed) {
          // если пройден первый уровень без подсказки, то открыть уровень tut6x6n2
          _state = _state.copyWith(
            isWin: true,
            nextLevelId: 'tut6x6n2',
            rating: _level.copyWith(moves: _moves).rating,
            bestResult: _level.bestResult,
          );
        } else if ((_state.levelId == 'tut6x6n1' && _state.solutionUsed) ||
            _state.levelId == 'tut6x6n2') {
          // если пройден первый уровень с подсказкой или пройден второй уровень, то открыть уровень tut6x6n3
          _state = _state.copyWith(
            isWin: true,
            nextLevelId: 'tut6x6n3',
            rating: _level.copyWith(moves: _moves).rating,
            bestResult: _level.bestResult,
          );
        } else {
          // если пройден третий уровень
          _state = _state.copyWith(
            isWin: true,
            rating: _level.copyWith(moves: _moves).rating,
            bestResult: _level.bestResult,
          );
        }
        notifyListeners();
      }
    });
  }

// -------- NON PUBLIC --------//

  int get _moves {
    return int.parse(_state.moves);
  }

  LevelEntity get _level {
    return TutorialLevels.levels
        .firstWhere((level) => level.id == _state.levelId)
        .copyWithBools(cells: _state.cells);
  }

  List<bool> get _initCells {
    LevelEntity level =
        TutorialLevels.levels.firstWhere((level) => level.id == _state.levelId);
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
    return int.parse(_state.singleFlips);
  }

  void _singleFlipsDecrement() async {
    _state = _state.copyWith(singleFlips: (_singleFlipsNumber - 1).toString());
  }

  void _solutionsDecrement() async {
    _state =
        _state.copyWith(solutionsNumber: (_solutionsNumber - 1).toString());
  }

  bool get _canUseSingleFlips {
    return _singleFlipsNumber > 0 && !_state.isSolutionOn;
  }

  int get _solutionsNumber {
    return int.parse(_state.solutionsNumber);
  }

  bool get _canUseSolution {
    return _solutionsNumber > 0 &&
        !_state.isSingleFlipOn &&
        !_state.isSolutionOn;
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
