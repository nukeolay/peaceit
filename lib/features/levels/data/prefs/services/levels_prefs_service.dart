import 'dart:convert';

import 'package:darkit/features/levels/data/prefs/model/levels_prefs_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LevelsPrefsService {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  Future<LevelsPrefsModel> load() async {
    print((await _prefs).getString('completedLevels')!);
    return LevelsPrefsModel.fromJson(
      jsonDecode((await _prefs).getString('completedLevels')!),
    );
  }

  Future<void> save(LevelsPrefsModel levelsPrefsModel) async {
    print(jsonEncode(levelsPrefsModel));
    (await _prefs).setString('completedLevels', jsonEncode(levelsPrefsModel));
  }
}
