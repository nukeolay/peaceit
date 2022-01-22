import 'package:makeitdark/core/models/cell.dart';

class Level {
  String id;
  List<Cell> cells;
  int bestResult;
  int goodResult;

  Level({
    required this.id,
    required this.cells,
    required this.bestResult,
    required this.goodResult,
  });
}
