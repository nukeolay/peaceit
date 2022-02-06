import 'package:darkit/core/constants/default_levels.dart';
import 'package:darkit/features/levels/data/prefs/levels_prefs_util.dart';
import 'package:darkit/features/levels/domain/entities/levels_entity.dart';
import 'package:darkit/features/levels/domain/repositories/levels_repository.dart';

class LevelsRepositoryImpl implements LevelsRepository {
  final LevelsPrefsUtil _prefsLevelsUtil;
  late LevelsEntity _levels;

  LevelsRepositoryImpl(this._prefsLevelsUtil);

  @override
  LevelsEntity get levels => _levels;

  @override
  Future<void> load() async {
    try {
      _levels = await _prefsLevelsUtil.load();
    } catch (_) {
      _levels = LevelsEntity(levels: DefaultLevels.levels);
    }
  }

  @override
  Future<void> save(LevelsEntity levels) {
    return _prefsLevelsUtil.save(levels);
  }
}
