import 'package:peaceit/core/constants/default_levels.dart';
import 'package:peaceit/data/levels/prefs/model/levels_prefs_model.dart';
import 'package:peaceit/domain/levels/entities/level_entity.dart';

class LevelsMapper {
  static List<LevelEntity> fromPrefs(LevelsPrefsModel levelsPrefsModel) {
    return DefaultLevels.levels.map((level) {
      if (levelsPrefsModel.completedLevels.containsKey(level.id)) {
        return level.copyWith(
            moves: levelsPrefsModel.completedLevels[level.id]!);
      }
      return level;
    }).toList();
  }

  static LevelsPrefsModel toPrefs(List<LevelEntity> levels) {
    return LevelsPrefsModel(completedLevels: {
      for (LevelEntity level in levels)
        if (level.moves > 0) level.id: level.moves
    });
  }
}
