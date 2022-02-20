import 'package:darkit/domain/levels/entities/cell_entity.dart';

class ConstructorViewModelState {
  final String moves;
  final List<CellEntity> cells;
  final List<CellEntity> inputCells;
  final int fieldLength;

  ConstructorViewModelState({
    this.moves = '',
    this.cells = const [],
    this.inputCells = const [],
    this.fieldLength = 0,
  });

  ConstructorViewModelState copyWith({
    String? moves,
    List<CellEntity>? cells,
    List<CellEntity>? inputCells,
    int? fieldLength,
  }) {
    return ConstructorViewModelState(
      moves: moves ?? this.moves,
      cells: cells ?? this.cells,
      inputCells: inputCells ?? this.inputCells,
      fieldLength: fieldLength ?? this.fieldLength,
    );
  }
}
