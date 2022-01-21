import 'package:makeitdark/models/cell.dart';

class Level {
  List<Cell> cells;
  int bestResult;
  int goodResult;

  Level({
    required this.cells,
    required this.bestResult,
    required this.goodResult,
  });
}
