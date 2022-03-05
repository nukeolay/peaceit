import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import 'package:peaceit/data/hints/prefs/model/hints_prefs_model.dart';

class HintsPrefsService {
  final SharedPreferences _prefs;

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
