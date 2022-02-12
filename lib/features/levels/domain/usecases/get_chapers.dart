import 'package:darkit/features/levels/domain/entities/chapter_entity.dart';
import 'package:darkit/features/levels/domain/entities/level_entity.dart';
import 'package:darkit/features/levels/domain/repositories/levels_repository.dart';

class GetChapters {
  final LevelsRepository _levelsRepository;
  GetChapters(this._levelsRepository);
  List<ChapterEntity> call() {
    final List<LevelEntity> _levels = _levelsRepository.levels;
    final List<ChapterEntity> _chapters = [];
    final List<String> chapterIds = [];
    for (LevelEntity level in _levels) {
      if (!chapterIds.contains(level.chapterId)) {
        chapterIds.add(level.chapterId);
        _chapters.add(ChapterEntity(id: level.chapterId, levels: [level]));
      } else {
        _chapters
            .firstWhere((chapter) => chapter.id == level.chapterId)
            .levels
            .add(level);
      }
    }
    return _chapters;
  }
}
