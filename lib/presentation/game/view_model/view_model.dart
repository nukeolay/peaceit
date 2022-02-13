import 'package:flutter/material.dart';

import 'package:darkit/presentation/game/view_model/view_model_state.dart';

class GameViewModel extends ChangeNotifier {
  GameViewModelState _state = GameViewModelState();

  GameViewModelState get state => _state;

  GameViewModel() {
    _init();
  }

  void _init() {
    // _chapters.clear();
    // _chapters.addAll(serviceLocator<GetChapters>().call());
    _state = _state.copyWith(
      level: _level,
      moves: _moves,
    );
  }

  void _updateState() {
    _init();
    notifyListeners();
  }

  void update() {
    _updateState();
  }

  String get _level {
    return ''; // !
  }

  String get _moves {
    return ''; // !
  }

  void useSingleFlip() {
    // !
  }
}
