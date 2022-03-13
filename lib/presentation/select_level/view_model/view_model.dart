import 'dart:math';

import 'package:flutter/material.dart';

import 'package:peaceit/domain/levels/entities/cell_entity.dart';
import 'package:peaceit/domain/levels/entities/level_entity.dart';
import 'package:peaceit/domain/levels/usecases/get_levels.dart';
import 'package:peaceit/presentation/select_level/view_model/view_model_state.dart';
import 'package:peaceit/internal/service_locator.dart';

class SelectLevelViewModel extends ChangeNotifier {
  SelectLevelViewModelState _state = SelectLevelViewModelState();

  SelectLevelViewModelState get state => _state;
  final String _chapterId;

  SelectLevelViewModel(this._chapterId) {
    _init();
  }

  final List<LevelEntity> _levels = [];

  void _init() {
    _levels.clear();
    _levels.addAll(serviceLocator<GetLevels>()
        .call()
        .where((level) => level.chapterId == _chapterId));
    _state = _state.copyWith(
      levels: _levelIds,
      levelsNumber: _levelsNumber,
      cells: _cells,
      cellsQuantity: _cellsQuantity,
      levelNumber: _levelNumber,
      rating: _rating,
      canBePlayed: _canBePlayed,
    );
  }

  void _updateState() {
    _init();
    notifyListeners();
  }

  void update() {
    _updateState();
  }

  List<String> get _levelIds {
    return _levels.map((level) => level.id).toList();
  }

  int get _levelsNumber => _levels.length;

  List<List<CellEntity>> get _cells {
    return _levels.map((level) => level.cells).toList();
  }

  List<int> get _cellsQuantity {
    return _cells.map((level) => sqrt(level.length).toInt()).toList();
  }

  List<String> get _levelNumber {
    return _levels
        .map((level) => (_levels.indexOf(level) + 1).toString())
        .toList();
  }

  List<int> get _rating {
    return _levels.map((level) => level.rating).toList();
  }

  List<bool> get _canBePlayed {
    final List<bool> result = [];
    for (var level in _levels) {
      final levelIndex = _levels.indexOf(level);
      if (levelIndex == 0) {
        result.add(true); // if this is the first level
      } else {
        // if previous level is completed
        result.add(_levels[levelIndex - 1].moves > 0);
      }
    }
    return result;
  }
}
