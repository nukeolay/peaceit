import 'dart:math';

import 'package:flutter/material.dart';

import 'package:peaceit/domain/levels/entities/cell_entity.dart';
import 'package:peaceit/domain/levels/entities/level_entity.dart';
import 'package:peaceit/domain/levels/usecases/normal_flip.dart';
import 'package:peaceit/presentation/level_constructor/view_model/view_model_state.dart';
import 'package:peaceit/presentation/level_constructor/view_model/blank_levels.dart';

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
