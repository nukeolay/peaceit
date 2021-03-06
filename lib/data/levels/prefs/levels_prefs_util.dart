import 'package:peaceit/data/levels/mapper/levels_mapper.dart';
import 'package:peaceit/data/levels/prefs/model/levels_prefs_model.dart';
import 'package:peaceit/data/levels/prefs/services/levels_prefs_service.dart';
import 'package:peaceit/domain/levels/entities/level_entity.dart';

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
