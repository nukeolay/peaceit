class GameViewModelState {
  final String levelNumber;
  final String moves;
  final String singleFlips;
  final bool canUseSingleFlips;
  final bool isSingleFlipOn;
  final String solutionsNumber;
  final bool canUseSolution;
  final int fieldLength;
  final List<bool> cells;
  final List<bool> cellsToFlip;
  final int flashCellIndex;

  GameViewModelState({
    this.levelNumber = '',
    this.moves = '',
    this.singleFlips = '',
    this.canUseSingleFlips = false,
    this.isSingleFlipOn = false,
    this.solutionsNumber = '',
    this.canUseSolution = false,
    this.fieldLength = 0,
    this.cells = const [],
    this.cellsToFlip = const [],
    this.flashCellIndex = -1,
  });

  GameViewModelState copyWith({
    String? levelNumber,
    String? moves,
    String? singleFlips,
    bool? canUseSingleFlips,
    bool? isSingleFlipOn,
    String? solutionsNumber,
    bool? canUseSolution,
    int? fieldLength,
    List<bool>? cells,
    List<bool>? cellsToFlip,
    int? flashCellIndex,
  }) {
    return GameViewModelState(
      levelNumber: levelNumber ?? this.levelNumber,
      moves: moves ?? this.moves,
      singleFlips: singleFlips ?? this.singleFlips,
      canUseSingleFlips: canUseSingleFlips ?? this.canUseSingleFlips,
      isSingleFlipOn: isSingleFlipOn ?? this.isSingleFlipOn,
      solutionsNumber: solutionsNumber ?? this.solutionsNumber,
      canUseSolution: canUseSolution ?? this.canUseSolution,
      fieldLength: fieldLength ?? this.fieldLength,
      cells: cells ?? this.cells,
      cellsToFlip: cellsToFlip ?? this.cellsToFlip,
      flashCellIndex: flashCellIndex ?? this.flashCellIndex,
    );
  }
}
