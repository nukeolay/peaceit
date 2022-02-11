import 'package:darkit/core/constants/default_levels.dart';
import 'package:darkit/features/levels/data/prefs/model/levels_prefs_model.dart';
import 'package:darkit/features/levels/domain/entities/level_entity.dart';

class LevelsMapper {
  static List<LevelEntity> fromPrefs(LevelsPrefsModel levelsPrefsModel) {
    return DefaultLevels.levels.map((level) {
      if (levelsPrefsModel.completedLevels.containsKey(level.id)) {
        return level.copyWith(
            rating: levelsPrefsModel.completedLevels[level.id]!);
      }
      return level;
    }).toList();
  }

  static LevelsPrefsModel toPrefs(List<LevelEntity> levels) {
    return LevelsPrefsModel(completedLevels: {
      for (LevelEntity level in levels)
        if (level.rating > 0) level.id: level.rating
    });
  }
}
