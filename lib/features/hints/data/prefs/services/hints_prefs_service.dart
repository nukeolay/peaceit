import 'dart:convert';

import 'package:darkit/features/hints/data/prefs/model/hints_prefs_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HintsPrefsService {
  final SharedPreferences _prefs; // !  = SharedPreferences.getInstance()

  HintsPrefsService(this._prefs);

  Future<HintsPrefsModel> load() async {
    return HintsPrefsModel.fromJson(
      jsonDecode(_prefs.getString('hints')!),
    );
  }

  Future<void> save(HintsPrefsModel hintsPrefsModel) async {
    await _prefs.setString('hints', jsonEncode(hintsPrefsModel));
  }
}
