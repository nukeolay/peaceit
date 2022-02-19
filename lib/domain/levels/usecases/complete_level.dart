import 'package:darkit/domain/levels/entities/level_entity.dart';
import 'package:darkit/domain/levels/repositories/levels_repository.dart';

class CompleteLevel {
  final LevelsRepository _levelsRepository;
  CompleteLevel(this._levelsRepository);
  Future<void> call(LevelEntity _level) async {
    final savedLevels = _levelsRepository.levels;
    if (savedLevels.any((level) => level.id == _level.id)) {
      // если такой уровень был сохранен ранее
      int levelIndex = savedLevels.indexWhere((level) => level.id == _level.id);
      savedLevels[levelIndex] = _level;
    } else {
      // если такого уровня нет
      savedLevels.add(_level);
    }
    await _levelsRepository.save(savedLevels);
  }
}
