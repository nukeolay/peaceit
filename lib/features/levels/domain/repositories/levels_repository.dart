import 'package:darkit/features/levels/domain/entities/level_entity.dart';

abstract class LevelsRepository {
  List<LevelEntity> get levels;
  Future<void> load();
  Future<void> save(List<LevelEntity> levels);
}
