import 'dart:math';

import 'package:flutter/material.dart';

import 'package:darkit/features/levels/domain/entities/cell_entity.dart';
import 'package:darkit/features/levels/domain/entities/level_entity.dart';
import 'package:darkit/features/levels/domain/usecases/get_levels.dart';
import 'package:darkit/features/levels/presentation/select_level_screen/view_model/view_model_state.dart';
import 'package:darkit/internal/service_locator.dart';

class SelectLevelViewModel extends ChangeNotifier {
  SelectLevelViewModelState _state = SelectLevelViewModelState();

  SelectLevelViewModelState get state => _state;
  final String _chapterId;

  SelectLevelViewModel(this._chapterId) {
    _init(_chapterId);
  }

  final List<LevelEntity> _levels = [];

  void _init(String chapterId) {
    _levels.clear();
    _levels.addAll(serviceLocator<GetLevels>()
        .call()
        .where((level) => level.chapterId == chapterId));
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
    _init(_chapterId);
    notifyListeners();
  }

  void update() {
    _updateState();
    print('screen updated');
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
        result.add(true); // если это первый уровень
      } else {
        // если предыдущий уровень пройден
        result.add(_levels[levelIndex - 1].rating > 0);
      }
    }
    return result;
  }
}
