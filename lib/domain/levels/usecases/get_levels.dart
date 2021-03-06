import 'package:peaceit/domain/levels/entities/level_entity.dart';
import 'package:peaceit/domain/levels/repositories/levels_repository.dart';

class GetLevels {
  final LevelsRepository _levelsRepository;
  GetLevels(this._levelsRepository);
  List<LevelEntity> call() {
    return _levelsRepository.levels;
  }
}
