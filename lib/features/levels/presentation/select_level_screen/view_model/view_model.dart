import 'package:darkit/features/levels/domain/entities/cell_entity.dart';
import 'package:darkit/features/levels/domain/entities/levels_entity.dart';
import 'package:darkit/features/levels/presentation/select_level_screen/view_model/view_model_state.dart';

import 'package:flutter/material.dart';

// ! TODO переделать на levels
class SelectLevelViewModel extends ChangeNotifier {
  SelectLevelViewModelState _state = SelectLevelViewModelState();

  SelectLevelViewModelState get state => _state;

  SelectLevelViewModel(String chapterId) {
    _init(chapterId);
  }

  final List<LevelsEntity> _levels = [];

  void _init(String chapterId) {
    _levels.clear();
    // _levels.addAll(serviceLocator<GenerateLevels>().call(chapterId));
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
    _init('dommy----');
    notifyListeners();
  }

  void update() {
    _updateState();
  }

  // final List<ChapterEntity> _chapters =
  //     serviceLocator<GenerateChapters>().call();

  List<String> get _levelIds {
    return []; // !
  }

  int get _levelsNumber => 0; // !

  List<List<CellEntity>> get _cells {
    return []; // !
  }

  List<int> get _cellsQuantity {
    return []; // !
  }

  List<String> get _levelNumber {
    return []; // !
  }

  List<int> get _rating {
    return []; // !
  }

  List<bool> get _canBePlayed {
    return []; // !
  }
}
