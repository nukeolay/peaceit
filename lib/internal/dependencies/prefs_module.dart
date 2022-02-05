import 'package:darkit/data/prefs/prefs_util.dart';
import 'package:darkit/internal/dependencies/shared_prefs_service.dart';

class PrefsModule {
  static PrefsUtil? _prefsUtil;

  static PrefsUtil get prefsUtil {

    _prefsUtil ??= PrefsUtil(SharedPrefsServiceModule.sharedPrefsService);

    return _prefsUtil!;
  }
}
