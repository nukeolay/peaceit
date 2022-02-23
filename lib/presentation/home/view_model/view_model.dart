import 'package:flutter/material.dart';

import 'package:darkit/internal/service_locator.dart';
import 'package:darkit/presentation/home/view_model/view_model_state.dart';
import 'package:darkit/domain/levels/usecases/get_levels.dart';

class HomeViewModel extends ChangeNotifier {
  late HomeViewModelState _state;

  HomeViewModelState get state => _state;

  HomeViewModel() {
    _init();
  }

  void _init() {
    _state = HomeViewModelState(
      !serviceLocator<GetLevels>().call().any((level) => level.moves > 0),
    );
  }

  bool checkIsFirstStart() {
    _state = HomeViewModelState(
      !serviceLocator<GetLevels>().call().any((level) => level.moves > 0),
    );
    return _state.isFirstStart;
  }
}
