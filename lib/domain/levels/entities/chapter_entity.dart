import 'package:darkit/domain/levels/entities/level_entity.dart';

class ChapterEntity {
  final String id;
  final List<LevelEntity> levels;

  ChapterEntity({
    required this.id,
    required this.levels,
  });

  ChapterEntity copyWith({
    String? id,
    List<LevelEntity>? levels,
  }) {
    return ChapterEntity(
      id: id ?? this.id,
      levels: levels ?? this.levels,
    );
  }

  int get levelsNumber => levels.length;

  int get completedLevelsNumber =>
      levels.where((level) => level.moves > 0).length;

  double get completedRatio => completedLevelsNumber / levelsNumber;

  int levelIndex(String levelId) {
    return levels.indexOf(levels.firstWhere((level) => level.id == levelId));
  }
}
