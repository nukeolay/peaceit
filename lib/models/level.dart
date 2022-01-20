import 'package:makeitdark/models/cell.dart';

class Level {
  List<Cell> cells;
  int bestResult;
  int goodResult;
  int badResult;

  Level({
    required this.cells,
    required this.bestResult,
    required this.goodResult,
    required this.badResult,
  });
}
