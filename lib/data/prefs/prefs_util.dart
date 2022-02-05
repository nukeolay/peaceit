import 'package:darkit/domain/entities/user_data.dart';
import 'package:darkit/data/mapper/user_data_mapper.dart';
import 'package:darkit/data/prefs/model/user_data_prefs_model.dart';
import 'package:darkit/data/prefs/services/shared_prefs_service.dart';

class PrefsUtil {
  final SharedPrefsService _sharedPrefsService;

  PrefsUtil(this._sharedPrefsService);

  Future<UserData> load() async {
    final UserDataPrefsModel result = await _sharedPrefsService.load();
    return DataUserMapper.fromPrefs(result);
  }

  Future<void> save(UserData userData) async {
    return await _sharedPrefsService.save(DataUserMapper.toPrefs(userData));
  }
}
