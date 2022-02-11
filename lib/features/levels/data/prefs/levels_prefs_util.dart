import 'package:darkit/features/levels/data/mapper/levels_mapper.dart';
import 'package:darkit/features/levels/data/prefs/model/levels_prefs_model.dart';
import 'package:darkit/features/levels/data/prefs/services/levels_prefs_service.dart';
import 'package:darkit/features/levels/domain/entities/level_entity.dart';

class LevelsPrefsUtil {
  final LevelsPrefsService _levelsPrefsService;

  LevelsPrefsUtil(this._levelsPrefsService);

  Future<List<LevelEntity>> load() async {
    final LevelsPrefsModel result = await _levelsPrefsService.load();
    return LevelsMapper.fromPrefs(result);
  }

  Future<void> save(List<LevelEntity> levels) async {
    return await _levelsPrefsService.save(LevelsMapper.toPrefs(levels));
  }
}
