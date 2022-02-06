import 'package:darkit/features/hints/data/prefs/hints_prefs_util.dart';
import 'package:darkit/features/hints/data/prefs/services/hints_prefs_service.dart';
import 'package:darkit/features/hints/data/repositories/hints_repository_impl.dart';
import 'package:darkit/features/hints/domain/repositories/hints_repository.dart';

class HintsRepositoryModule {
  static HintsRepository? _hintsRepository;

  static HintsRepository get hintsRepository {
    _hintsRepository ??= HintsRepositoryImpl(
      HintsPrefsModule.prefsHintsUtil,
    );
    return _hintsRepository!;
  }
}

class HintsPrefsModule {
  static HintsPrefsUtil? _hintsPrefsUtil;

  static HintsPrefsUtil get prefsHintsUtil {
    _hintsPrefsUtil ??=
        HintsPrefsUtil(HintsPrefsServiceModule.hintsPrefsService);

    return _hintsPrefsUtil!;
  }
}

class HintsPrefsServiceModule {
  static HintsPrefsService? _hintsPrefsService;

  static HintsPrefsService get hintsPrefsService {
    _hintsPrefsService ??= HintsPrefsService();
    return _hintsPrefsService!;
  }
}
