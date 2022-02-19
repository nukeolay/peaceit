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

  // TODO вместо поля bestResult сделать геттер, который считат length solution
  // ! int get bestResultEXPERIMENT => solution.length;

  // TODO вместо поля goodResult сделать геттер, который считат length solution * 1.5
  // ! int get goodResultEXPERIMENT => (bestResult * 1.5).ceil() + 1;

  // TODO вместо поля rating добавить поле moves, записывать количество шагов, за которое пройден уровень
  

  // TODO сделать геттер rating, который будет возвращать рейтинг исходя из moves и best/good result

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
