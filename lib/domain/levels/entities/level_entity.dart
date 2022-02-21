import 'package:darkit/domain/levels/entities/cell_entity.dart';

class LevelEntity {
  final String id;
  final String chapterId;
  final List<CellEntity> cells;
  final List<CellEntity> solution;
  final int moves;

  const LevelEntity({
    required this.id,
    required this.chapterId,
    required this.cells,
    required this.solution,
    this.moves = 0,
  });

  int get bestResult => solution.length;

  int get goodResult => (bestResult * 1.5).ceil() + 1;

  int get rating {
    if (moves == 0) return 0;
    if (moves <= bestResult) return 3;
    if (moves <= goodResult) return 2;
    return 1;
  }

  LevelEntity copyWith({
    required int moves,
  }) {
    return LevelEntity(
      id: id,
      chapterId: chapterId,
      cells: cells,
      solution: solution,
      moves: moves,
    );
  }

  @override
  String toString() {
    return 'id: $id, chapterId: $chapterId, moves: $moves';
  }
}
