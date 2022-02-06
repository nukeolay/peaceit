import 'package:darkit/features/levels/data/mapper/levels_mapper.dart';
import 'package:darkit/features/levels/data/prefs/model/levels_prefs_model.dart';
import 'package:darkit/features/levels/data/prefs/services/levels_prefs_service.dart';
import 'package:darkit/features/levels/domain/entities/levels_entity.dart';

class PrefsLevelsUtil {
  final LevelsPrefsService _levelsPrefsService;

  PrefsLevelsUtil(this._levelsPrefsService);

  Future<LevelsEntity> load() async {
    final LevelsPrefsModel result = await _levelsPrefsService.load();
    return LevelsMapper.fromPrefs(result);
  }

  Future<void> save(LevelsEntity levels) async {
    return await _levelsPrefsService.save(LevelsMapper.toPrefs(levels));
  }
}
