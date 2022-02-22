import 'package:darkit/domain/levels/entities/cell_entity.dart';

class ConstructorViewModelState {
  final String levelId;
  final String moves;
  final List<CellEntity> cells;
  final List<CellEntity> inputCells;
  final int fieldLength;

  ConstructorViewModelState({
    this.levelId = '',
    this.moves = '0',
    this.cells = const [],
    this.inputCells = const [],
    this.fieldLength = 0,
  });

  ConstructorViewModelState copyWith({
    String? levelId,
    String? moves,
    List<CellEntity>? cells,
    List<CellEntity>? inputCells,
    int? fieldLength,
  }) {
    return ConstructorViewModelState(
      levelId: levelId ?? this.levelId,
      moves: moves ?? this.moves,
      cells: cells ?? this.cells,
      inputCells: inputCells ?? this.inputCells,
      fieldLength: fieldLength ?? this.fieldLength,
    );
  }
}
