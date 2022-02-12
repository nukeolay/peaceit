import 'package:darkit/core/constants/default_levels.dart';
import 'package:darkit/data/levels/prefs/levels_prefs_util.dart';
import 'package:darkit/domain/levels/entities/level_entity.dart';
import 'package:darkit/domain/levels/repositories/levels_repository.dart';


class LevelsRepositoryImpl implements LevelsRepository {
  final LevelsPrefsUtil _prefsLevelsUtil;
  late List<LevelEntity> _levels;

  LevelsRepositoryImpl(this._prefsLevelsUtil);

  @override
  List<LevelEntity> get levels => _levels;

  @override
  Future<void> load() async {
    try {
      _levels = await _prefsLevelsUtil.load();
    } catch (_) {
      _levels = DefaultLevels.levels;
    }
  }

  @override
  Future<void> save(List<LevelEntity> levels) {
    _levels = levels;
    return _prefsLevelsUtil.save(levels);
  }
}
