import 'package:darkit/core/constants/default_levels.dart';
import 'package:darkit/features/levels/data/prefs/model/levels_prefs_model.dart';
import 'package:darkit/features/levels/domain/entities/levels_entity.dart';

class LevelsMapper {
  static LevelsEntity fromPrefs(LevelsPrefsModel levelsPrefsModel) {
    return LevelsEntity(
      levels: DefaultLevels.levels.map((level) {
        if (levelsPrefsModel.completedLevels.containsKey(level.id)) {
          return level.copyWith(
              rating: levelsPrefsModel.completedLevels[level.id]!);
        }
        return level;
      }).toList(), // TODO преобразую, добавляю к levels рейтинг из completed levels
    );
  }

  static LevelsPrefsModel toPrefs(LevelsEntity levels) {
    return LevelsPrefsModel(
      completedLevels: Map<String, int>.fromIterable(
        levels.levels.where((level) => level.rating > 0).map(
              (level) => MapEntry(level.id, level.rating),
            ),
      ), // TODO преобразую, выбираю только пройденные уровни, где рейтинг больше 0
    );
  }
}
