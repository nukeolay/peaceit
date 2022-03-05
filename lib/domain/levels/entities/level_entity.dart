import 'package:peaceit/domain/levels/entities/cell_entity.dart';

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

  List<bool> get boolCells {
    return cells.map((cell) => cell.isBlack).toList();
  }

  int get rating {
    if (moves == 0) return 0;
    if (moves <= bestResult) return 3;
    if (moves <= goodResult) return 2;
    return 1;
  }

  int cellIndexByCoordinates(int x, int y) {
    CellEntity cell = cells.firstWhere((cell) => cell.x == x && cell.y == y,
        orElse: () => const CellEntity(999, 999));
    return cells.indexOf(cell);
  }

  LevelEntity copyWith({
    int? moves,
    List<CellEntity>? cells,
  }) {
    return LevelEntity(
      id: id,
      chapterId: chapterId,
      cells: cells ?? this.cells,
      solution: solution,
      moves: moves ?? this.moves,
    );
  }

  LevelEntity copyWithBools({
    required List<bool> cells,
  }) {
    List<CellEntity> cellsFromBools = this
        .cells
        .map((cell) => CellEntity(
            cell.x, cell.y, cells[cellIndexByCoordinates(cell.x, cell.y)]))
        .toList();
    return LevelEntity(
      id: id,
      chapterId: chapterId,
      cells: cellsFromBools,
      solution: solution,
      moves: moves,
    );
  }

  @override
  String toString() {
    return 'id: $id, chapterId: $chapterId, moves: $moves';
  }
}
