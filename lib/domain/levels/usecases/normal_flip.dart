import 'package:darkit/domain/levels/entities/level_entity.dart';

class NormalFlip {
  int index;
  LevelEntity level;

  NormalFlip({
    required this.index,
    required this.level,
  });

  LevelEntity call() {
    List<bool> cells = level.boolCells;
    int x = level.cells[index].x;
    int y = level.cells[index].y;
    cells[index] = !cells[index];
    try {
      index = level.cellIndexByCoordinates(x, y - 1);
      cells[index] = !cells[index];
    } catch (error) {}
    try {
      index = level.cellIndexByCoordinates(x, y + 1);
      cells[index] = !cells[index];
    } catch (error) {}
    try {
      index = level.cellIndexByCoordinates(x - 1, y);
      cells[index] = !cells[index];
    } catch (error) {}
    try {
      index = level.cellIndexByCoordinates(x + 1, y);
      cells[index] = !cells[index];
    } catch (error) {}
    return level.copyWithBools(cells: cells);
  }
}
