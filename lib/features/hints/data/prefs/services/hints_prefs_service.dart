import 'dart:convert';

import 'package:darkit/features/hints/data/prefs/model/hints_prefs_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HintsPrefsService {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  Future<HintsPrefsModel> load() async {
    print((await _prefs).getString('hints')!);
    return HintsPrefsModel.fromJson(
      jsonDecode((await _prefs).getString('hints')!),
    );
  }

  Future<void> save(HintsPrefsModel hintsPrefsModel) async {
    print(jsonEncode(hintsPrefsModel));
    (await _prefs).setString('hints', jsonEncode(hintsPrefsModel));
  }
}
