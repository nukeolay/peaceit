import 'package:darkit/features/levels/domain/entities/level_entity.dart';
import 'package:darkit/features/levels/domain/repositories/levels_repository.dart';

class ResetLevels {
  final LevelsRepository _levelsRepository;
  ResetLevels(this._levelsRepository);
  Future<List<LevelEntity>> call() async {
    final List<LevelEntity> _levels = _levelsRepository.levels;
    final List<LevelEntity> _newLevels =
        _levels.map((level) => level.copyWith(rating: 0)).toList();
    await _levelsRepository.save(_newLevels);
    return _levelsRepository.levels;
  }
}
