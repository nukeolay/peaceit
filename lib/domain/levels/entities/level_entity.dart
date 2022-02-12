import 'package:darkit/domain/levels/entities/cell_entity.dart';

class LevelEntity {
  final String id;
  final String chapterId;
  final List<CellEntity> cells;
  final List<CellEntity> solution;
  final int bestResult;
  final int goodResult;
  final int rating;

  const LevelEntity({
    required this.id,
    required this.chapterId,
    required this.cells,
    required this.solution,
    required this.bestResult,
    required this.goodResult,
    this.rating = 0,
  });

  LevelEntity copyWith({
    required int rating,
  }) {
    return LevelEntity(
      id: id,
      chapterId: chapterId,
      cells: cells,
      solution: solution,
      bestResult: bestResult,
      goodResult: goodResult,
      rating: rating,
    );
  }

  @override
  String toString() {
    return 'id: $id, chapterId: $chapterId, rating: $rating';
  }
}
