import 'dart:convert';

import 'package:darkit/features/levels/data/prefs/model/levels_prefs_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LevelsPrefsService {
  final SharedPreferences _prefs;

  LevelsPrefsService(this._prefs);

  Future<LevelsPrefsModel> load() async {
    return LevelsPrefsModel.fromJson(
      jsonDecode(_prefs.getString('completedLevels')!),
    );
  }

  Future<void> save(LevelsPrefsModel levelsPrefsModel) async {
    await _prefs.setString('completedLevels', jsonEncode(levelsPrefsModel));
  }
}
