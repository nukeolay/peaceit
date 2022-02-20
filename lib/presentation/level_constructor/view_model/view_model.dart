import 'dart:math';

import 'package:flutter/material.dart';

import 'package:darkit/domain/levels/entities/cell_entity.dart';
import 'package:darkit/presentation/level_constructor/view_model/view_model_state.dart';
import 'package:darkit/domain/levels/entities/level_entity.dart';
import 'package:darkit/domain/levels/usecases/get_levels.dart';
import 'package:darkit/internal/service_locator.dart';

class ConstructorViewModel extends ChangeNotifier {
  ConstructorViewModelState _state = ConstructorViewModelState();

  ConstructorViewModelState get state => _state;

  final String _levelId;
  int _moves = 0;
  late final LevelEntity _level;
  late List<CellEntity> _cells;
  late List<CellEntity> _inputCells;

  bool _isInit = true;

  ConstructorViewModel(this._levelId) {
    _init();
  }

  void _init() {
    if (_isInit) {
      _level = BlankLevels.levels.firstWhere((level) => level.id == _levelId);
      _cells = [
        ..._level.cells.map(
          (cell) => CellEntity(
            cell.x,
            cell.y,
            cell.isBlack,
          ),
        )
      ];
      _inputCells = [];
      _state = _state.copyWith(
        moves: _moves.toString(),
        cells: _level.cells,
        fieldLength: sqrt(_level.cells.length).toInt(),
      );
      _isInit = false;
    }
  }

  void flipCard(CellEntity cell) {
    _moves++;
    _inputCells.add(cell);
    _normalFlip(cell);
    _state = _state.copyWith(
      moves: _moves.toString(),
      inputCells: _inputCells,
      cells: _cells,
    );
    notifyListeners();
  }

  void _normalFlip(CellEntity cell) {
    int x = cell.x;
    int y = cell.y;
    _cellIndexByCoordinates(x, y).switchIt();
    try {
      _cellIndexByCoordinates(x, y - 1).switchIt();
    } catch (error) {}
    try {
      _cellIndexByCoordinates(x, y + 1).switchIt();
    } catch (error) {}
    try {
      _cellIndexByCoordinates(x - 1, y).switchIt();
    } catch (error) {}
    try {
      _cellIndexByCoordinates(x + 1, y).switchIt();
    } catch (error) {}
  }

  CellEntity _cellIndexByCoordinates(int x, int y) {
    return _cells.firstWhere((cell) => cell.x == x && cell.y == y);
  }
}

class BlankLevels {
  static final List<LevelEntity> levels = [
    LevelEntity(
        id: 'new 3x3',
        chapterId: 'edt 3x3',
        bestResult: 4,
        goodResult: 7,
        cells: [
          CellEntity(1, 1),
          CellEntity(2, 1),
          CellEntity(3, 1),
          CellEntity(1, 2),
          CellEntity(2, 2),
          CellEntity(3, 2),
          CellEntity(1, 3),
          CellEntity(2, 3),
          CellEntity(3, 3),
        ],
        solution: [
          CellEntity(0, 0),
          CellEntity(0, 0),
          CellEntity(0, 0),
          CellEntity(0, 0),
        ]),
    LevelEntity(
        id: 'new 4x4',
        chapterId: 'edt 4x4',
        bestResult: 4,
        goodResult: 7,
        cells: [
          CellEntity(1, 1),
          CellEntity(2, 1),
          CellEntity(3, 1),
          CellEntity(4, 1),
          CellEntity(1, 2),
          CellEntity(2, 2),
          CellEntity(3, 2),
          CellEntity(4, 2),
          CellEntity(1, 3),
          CellEntity(2, 3),
          CellEntity(3, 3),
          CellEntity(4, 3),
          CellEntity(1, 4),
          CellEntity(2, 4),
          CellEntity(3, 4),
          CellEntity(4, 4),
        ],
        solution: [
          CellEntity(0, 0),
          CellEntity(0, 0),
          CellEntity(0, 0),
          CellEntity(0, 0),
        ]),
  ];
}
