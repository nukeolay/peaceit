import 'package:darkit/domain/levels/entities/cell_entity.dart';

class GameViewModelState {
  final String levelNumber;
  final String moves;
  final String singleFlips;
  final bool canUseSingleFlips;
  final bool isSingleFlipOn;
  final String solutionsNumber;
  final bool canUseSolution;
  final List<CellEntity> cells;

  GameViewModelState({
    this.levelNumber = '',
    this.moves = '',
    this.singleFlips = '',
    this.canUseSingleFlips = false,
    this.isSingleFlipOn = false,
    this.solutionsNumber = '',
    this.canUseSolution = false,
    this.cells = const [],
  });

  GameViewModelState copyWith({
    String? levelNumber,
    String? moves,
    String? singleFlips,
    bool? canUseSingleFlips,
    bool? isSingleFlipOn,
    String? solutionsNumber,
    bool? canUseSolution,
    List<CellEntity>? cells,
  }) {
    return GameViewModelState(
      levelNumber: levelNumber ?? this.levelNumber,
      moves: moves ?? this.moves,
      singleFlips: singleFlips ?? this.singleFlips,
      canUseSingleFlips: canUseSingleFlips ?? this.canUseSingleFlips,
      isSingleFlipOn: isSingleFlipOn ?? this.isSingleFlipOn,
      solutionsNumber: solutionsNumber ?? this.solutionsNumber,
      canUseSolution: canUseSolution ?? this.canUseSolution,
      cells: cells ?? this.cells,
    );
  }
}
