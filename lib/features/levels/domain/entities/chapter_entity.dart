import 'package:darkit/features/levels/domain/entities/level_entity.dart';

class ChapterEntity {
  String id;
  List<LevelEntity> levels;

  ChapterEntity({
    required this.id,
    required this.levels,
  });

  int get levelsNumber => levels.length;

  int get completedLevelsNumber =>
      levels.where((level) => level.rating > 0).length;

  double get completedRatio => completedLevelsNumber / levelsNumber;

  int levelIndexById(String levelId) {
    return levels.indexOf(levels.firstWhere((level) => level.id == levelId));
  }
}