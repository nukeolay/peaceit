import 'dart:math';

import 'package:flutter/material.dart';

import 'package:darkit/domain/levels/entities/cell_entity.dart';
import 'package:darkit/domain/levels/entities/level_entity.dart';
import 'package:darkit/domain/levels/usecases/normal_flip.dart';
import 'package:darkit/presentation/level_constructor/view_model/view_model_state.dart';

class ConstructorViewModel extends ChangeNotifier {
  late ConstructorViewModelState _state;

  ConstructorViewModelState get state => _state;

  ConstructorViewModel(String levelId) {
    _init(levelId);
  }

  void _init(String levelId) {
    List<CellEntity> cells = BlankLevels.levels
        .firstWhere((level) => level.id == levelId)
        .cells
        .map((cell) => CellEntity(cell.x, cell.y, cell.isBlack))
        .toList();
    _state = ConstructorViewModelState(
      levelId: levelId,
      cells: cells,
      fieldLength: sqrt(cells.length).toInt(),
    );
  }

  int get _moves {
    return int.parse(_state.moves);
  }

  void flipCard(int index) {
    List<CellEntity> inputCells = [..._state.inputCells, _state.cells[index]];
    LevelEntity level = NormalFlip(
            index: index, level: _blankLevel.copyWith(cells: _state.cells))
        .call();
    _state = _state.copyWith(
      moves: (_moves + 1).toString(),
      inputCells: inputCells,
      cells: level.cells,
    );
    notifyListeners();
  }

  void reset() {
    _init(_state.levelId);
    notifyListeners();
  }

  LevelEntity get _blankLevel =>
      BlankLevels.levels.firstWhere((level) => level.id == _state.levelId);
}

class BlankLevels {
  static const List<LevelEntity> levels = [
    LevelEntity(id: 'new 3x3', chapterId: 'edt 3x3', cells: [
      CellEntity(1, 1),
      CellEntity(2, 1),
      CellEntity(3, 1),
      CellEntity(1, 2),
      CellEntity(2, 2),
      CellEntity(3, 2),
      CellEntity(1, 3),
      CellEntity(2, 3),
      CellEntity(3, 3),
    ], solution: [
      CellEntity(0, 0),
      CellEntity(0, 0),
      CellEntity(0, 0),
      CellEntity(0, 0),
    ]),
    LevelEntity(id: 'new 4x4', chapterId: 'edt 4x4', cells: [
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
    ], solution: [
      CellEntity(0, 0),
      CellEntity(0, 0),
      CellEntity(0, 0),
      CellEntity(0, 0),
    ]),
    LevelEntity(id: 'new 5x5', chapterId: 'edt 5x5', cells: [
      CellEntity(1, 1),
      CellEntity(2, 1),
      CellEntity(3, 1),
      CellEntity(4, 1),
      CellEntity(5, 1),
      CellEntity(1, 2),
      CellEntity(2, 2),
      CellEntity(3, 2),
      CellEntity(4, 2),
      CellEntity(5, 2),
      CellEntity(1, 3),
      CellEntity(2, 3),
      CellEntity(3, 3),
      CellEntity(4, 3),
      CellEntity(5, 3),
      CellEntity(1, 4),
      CellEntity(2, 4),
      CellEntity(3, 4),
      CellEntity(4, 4),
      CellEntity(5, 4),
      CellEntity(1, 5),
      CellEntity(2, 5),
      CellEntity(3, 5),
      CellEntity(4, 5),
      CellEntity(5, 5),
    ], solution: [
      CellEntity(0, 0),
      CellEntity(0, 0),
      CellEntity(0, 0),
      CellEntity(0, 0),
    ]),
    LevelEntity(id: 'new 6x6', chapterId: 'edt 6x6', cells: [
      CellEntity(1, 1),
      CellEntity(2, 1),
      CellEntity(3, 1),
      CellEntity(4, 1),
      CellEntity(5, 1),
      CellEntity(6, 1),
      CellEntity(1, 2),
      CellEntity(2, 2),
      CellEntity(3, 2),
      CellEntity(4, 2),
      CellEntity(5, 2),
      CellEntity(6, 2),
      CellEntity(1, 3),
      CellEntity(2, 3),
      CellEntity(3, 3),
      CellEntity(4, 3),
      CellEntity(5, 3),
      CellEntity(6, 3),
      CellEntity(1, 4),
      CellEntity(2, 4),
      CellEntity(3, 4),
      CellEntity(4, 4),
      CellEntity(5, 4),
      CellEntity(6, 4),
      CellEntity(1, 5),
      CellEntity(2, 5),
      CellEntity(3, 5),
      CellEntity(4, 5),
      CellEntity(5, 5),
      CellEntity(6, 5),
      CellEntity(1, 6),
      CellEntity(2, 6),
      CellEntity(3, 6),
      CellEntity(4, 6),
      CellEntity(5, 6),
      CellEntity(6, 6),
    ], solution: [
      CellEntity(0, 0),
      CellEntity(0, 0),
      CellEntity(0, 0),
      CellEntity(0, 0),
    ]),
  ];
}
