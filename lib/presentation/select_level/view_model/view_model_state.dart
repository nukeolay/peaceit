import 'package:darkit/domain/levels/entities/cell_entity.dart';

class SelectLevelViewModelState {
  final List<String> levels;
  final int levelsNumber;
  final List<List<CellEntity>> cells;
  final List<int> cellsQuantity;
  final List<String> levelNumber;
  final List<int> rating;
  final List<bool> canBePlayed;

  SelectLevelViewModelState({
    this.levels = const [],
    this.levelsNumber = 0,
    this.cells = const [],
    this.cellsQuantity = const [],
    this.levelNumber = const [],
    this.rating = const [],
    this.canBePlayed = const [],
  });

  SelectLevelViewModelState copyWith({
    List<String>? levels,
    int? levelsNumber,
    List<List<CellEntity>>? cells,
    List<int>? cellsQuantity,
    List<String>? levelNumber,
    List<int>? rating,
    List<bool>? canBePlayed,
  }) {
    return SelectLevelViewModelState(
      levels: levels ?? this.levelNumber,
      levelsNumber: levelsNumber ?? this.levelsNumber,
      cells: cells ?? this.cells,
      cellsQuantity: cellsQuantity ?? this.cellsQuantity,
      levelNumber: levelNumber ?? this.levelNumber,
      rating: rating ?? this.rating,
      canBePlayed: canBePlayed ?? this.canBePlayed,
    );
  }
}