import 'package:darkit/data/prefs/services/shared_prefs_service.dart';

class SharedPrefsServiceModule {
  static SharedPrefsService? _sharedPrefsService;

  static SharedPrefsService get sharedPrefsService {
    _sharedPrefsService ??= SharedPrefsService();
    return _sharedPrefsService!;
  }
}
