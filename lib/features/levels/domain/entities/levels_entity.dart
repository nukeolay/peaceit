import 'package:darkit/features/levels/domain/entities/level_entity.dart';

class LevelsEntity {
  final List<LevelEntity> levels;

  LevelsEntity({
    required this.levels,
  });

  LevelsEntity copyWith({
    required List<LevelEntity> levels,
  }) {
    return LevelsEntity(
      levels: levels,
    );
  }
}
