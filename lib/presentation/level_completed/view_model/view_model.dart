import 'package:flutter/material.dart';

import 'package:darkit/presentation/level_completed/view_model/view_model_state.dart';

class LevelCompletedViewModel extends ChangeNotifier {
  LevelCompletedViewModelState _state = LevelCompletedViewModelState();

  LevelCompletedViewModelState get state => _state;
}
