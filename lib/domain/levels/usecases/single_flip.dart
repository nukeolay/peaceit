import 'package:peaceit/domain/levels/entities/level_entity.dart';

class SingleFlip {
  int index;
  LevelEntity level;

  SingleFlip({
    required this.index,
    required this.level,
  });

  LevelEntity call() {
    List<bool> cells = level.boolCells;
    cells[index] = !cells[index];
    return level.copyWithBools(cells: cells);
  }
}
