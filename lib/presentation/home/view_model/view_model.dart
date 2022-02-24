import 'package:flutter/material.dart';

import 'package:darkit/internal/service_locator.dart';
import 'package:darkit/domain/levels/usecases/get_levels.dart';

class HomeViewModel extends ChangeNotifier {
  bool checkIsFirstStart() {
    return !serviceLocator<GetLevels>().call().any((level) => level.moves > 0);
  }
}
