import 'dart:convert';

import 'package:peaceit/data/tutorial/prefs/model/tutorial_prefs_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TutorialPrefsService {
  final SharedPreferences _prefs;

  TutorialPrefsService(this._prefs);

  Future<TutorialPrefsModel> load() async {
    return TutorialPrefsModel.fromJson(
      jsonDecode(_prefs.getString('tutorial')!),
    );
  }

  Future<void> save(TutorialPrefsModel tutorialPrefsModel) async {
    await _prefs.setString('tutorial', jsonEncode(tutorialPrefsModel));
  }
}
