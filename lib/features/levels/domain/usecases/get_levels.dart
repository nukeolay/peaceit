import 'package:darkit/features/levels/domain/entities/level_entity.dart';
import 'package:darkit/features/levels/domain/repositories/levels_repository.dart';

class GetLevels {
  final LevelsRepository _levelsRepository;
  GetLevels(this._levelsRepository);
  List<LevelEntity> call() {
    return _levelsRepository.levels;
  }
}
