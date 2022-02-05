import 'dart:convert';

import 'package:darkit/data/prefs/model/user_data_prefs_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefsService {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  Future<UserDataPrefsModel> load() async {
    print((await _prefs).getString('userData')!);
    return UserDataPrefsModel.fromJson(
      jsonDecode((await _prefs).getString('userData')!),
    );
  }

  Future<void> save(UserDataPrefsModel userDataPrefsModel) async {
    print(jsonEncode(userDataPrefsModel));
    (await _prefs).setString('userData', jsonEncode(userDataPrefsModel));
  }
}
