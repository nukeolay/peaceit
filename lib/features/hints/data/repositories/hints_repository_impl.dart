import 'package:darkit/core/constants/default_game_settings.dart';
import 'package:darkit/features/hints/data/prefs/hints_prefs_util.dart';
import 'package:darkit/features/hints/domain/entities/hints_entity.dart';
import 'package:darkit/features/hints/domain/repositories/hints_repository.dart';

class HintsRepositoryImpl implements HintsRepository {
  final HintsPrefsUtil _prefsHintsUtil;
  late HintsEntity _hints;

  HintsRepositoryImpl(this._prefsHintsUtil);

  @override
  HintsEntity get hints => _hints;

  @override
  Future<void> load() async {
    try {
      _hints = await _prefsHintsUtil.load();
    } catch (_) {
      _hints = HintsEntity(
        singleFlips: DefaultGameSettings.singleFlips,
        solutionsNumber: DefaultGameSettings.solutionsNumber,
      );
    }
  }

  @override
  Future<void> save(HintsEntity hints) {
    _hints = hints;
    return _prefsHintsUtil.save(hints);
  }
}
