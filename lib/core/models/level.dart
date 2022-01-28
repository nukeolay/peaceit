import 'package:makeitdark/core/models/cell.dart';

class Level {
  String id;
  String chapterId;
  List<Cell> cells;
  List<Cell> solution;
  int bestResult;
  int goodResult;
  int rating;

  Level({
    required this.id,
    required this.chapterId,
    required this.cells,
    required this.solution,
    required this.bestResult,
    required this.goodResult,
    this.rating = 0,
  });
}
