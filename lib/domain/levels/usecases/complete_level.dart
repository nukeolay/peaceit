import 'package:peaceit/domain/levels/entities/level_entity.dart';
import 'package:peaceit/domain/levels/repositories/levels_repository.dart';

class CompleteLevel {
  final LevelsRepository _levelsRepository;
  CompleteLevel(this._levelsRepository);
  Future<void> call(LevelEntity _level) async {
    final savedLevels = [..._levelsRepository.levels];
    final levelIndex = savedLevels.indexWhere((level) => level.id == _level.id);
    savedLevels[levelIndex] = _level;
    await _levelsRepository.save(savedLevels);
  }
}
