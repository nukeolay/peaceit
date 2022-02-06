import 'package:darkit/features/levels/data/prefs/levels_prefs_util.dart';
import 'package:darkit/features/levels/data/prefs/services/levels_prefs_service.dart';
import 'package:darkit/features/levels/data/repositories/levels_repository_impl.dart';
import 'package:darkit/features/levels/domain/repositories/levels_repository.dart';

class LevelsRepositoryModule {
  static LevelsRepository? _levelsRepository;

  static LevelsRepository get levelsRepository {
    _levelsRepository ??= LevelsRepositoryImpl(
      LevelsPrefsModule.levelsPrefsUtil,
    );
    return _levelsRepository!;
  }
}

class LevelsPrefsModule {
  static LevelsPrefsUtil? _levelsPrefsUtil;

  static LevelsPrefsUtil get levelsPrefsUtil {
    _levelsPrefsUtil ??=
        LevelsPrefsUtil(LevelsPrefsServiceModule.levelsPrefsService);
    return _levelsPrefsUtil!;
  }
}

class LevelsPrefsServiceModule {
  static LevelsPrefsService? _levelsPrefsService;

  static LevelsPrefsService get levelsPrefsService {
    _levelsPrefsService ??= LevelsPrefsService();
    return _levelsPrefsService!;
  }
}
