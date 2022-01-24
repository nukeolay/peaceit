import 'package:makeitdark/core/models/cell.dart';

class Level {
  String id;
  List<Cell> cells;
  List<Cell> solution;
  int bestResult;
  int goodResult;

  Level({
    required this.id,
    required this.cells,
    required this.solution,
    required this.bestResult,
    required this.goodResult,
  });
}
