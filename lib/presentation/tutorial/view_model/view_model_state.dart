class TutorialViewModelState {
  final bool showIntroTutoriaDialog;
  final bool showSolutionTutoriaDialog;
  final bool showSingleFlipTutoriaDialog;
  final bool solutionUsed;
  final String levelId;
  final String? nextLevelId;
  final String levelNumber;
  final String moves;
  final int rating;
  final int bestResult;
  final String singleFlips;
  final bool canUseSingleFlips;
  final bool isSingleFlipOn;
  final String solutionsNumber;
  final bool canUseSolution;
  final bool isSolutionOn;
  final int fieldLength;
  final List<bool> cells;
  final List<bool> cellsToFlip;
  final int flashCellIndex;
  final bool isWin;
  final bool isEndTutorial;

  TutorialViewModelState({
    this.showIntroTutoriaDialog = true,
    this.showSolutionTutoriaDialog = false,
    this.showSingleFlipTutoriaDialog = false,
    this.solutionUsed = false,
    this.levelId = '',
    this.nextLevelId,
    this.levelNumber = '',
    this.moves = '0',
    this.rating = 0,
    this.bestResult = 0,
    this.singleFlips = '',
    this.canUseSingleFlips = false,
    this.isSingleFlipOn = false,
    this.solutionsNumber = '',
    this.canUseSolution = false,
    this.isSolutionOn = false,
    this.fieldLength = 0,
    this.cells = const [],
    this.cellsToFlip = const [],
    this.flashCellIndex = -1,
    this.isWin = false,
    this.isEndTutorial = false,
  });

  TutorialViewModelState copyWith({
    bool? showIntroTutoriaDialog,
    bool? showSolutionTutoriaDialog,
    bool? showSingleFlipTutoriaDialog,
    bool? solutionUsed,
    String? levelId,
    String? nextLevelId,
    String? levelNumber,
    String? moves,
    int? rating,
    int? bestResult,
    String? singleFlips,
    bool? canUseSingleFlips,
    bool? isSingleFlipOn,
    String? solutionsNumber,
    bool? canUseSolution,
    bool? isSolutionOn,
    int? fieldLength,
    List<bool>? cells,
    List<bool>? cellsToFlip,
    int? flashCellIndex,
    bool? isWin,
    bool? isEndTutorial,
  }) {
    return TutorialViewModelState(
      showIntroTutoriaDialog:
          showIntroTutoriaDialog ?? this.showIntroTutoriaDialog,
      showSolutionTutoriaDialog:
          showSolutionTutoriaDialog ?? this.showSolutionTutoriaDialog,
      showSingleFlipTutoriaDialog:
          showSingleFlipTutoriaDialog ?? this.showSingleFlipTutoriaDialog,
      solutionUsed: solutionUsed ?? this.solutionUsed,
      levelId: levelId ?? this.levelId,
      nextLevelId: nextLevelId,
      levelNumber: levelNumber ?? this.levelNumber,
      moves: moves ?? this.moves,
      rating: rating ?? this.rating,
      bestResult: bestResult ?? this.bestResult,
      singleFlips: singleFlips ?? this.singleFlips,
      canUseSingleFlips: canUseSingleFlips ?? this.canUseSingleFlips,
      isSingleFlipOn: isSingleFlipOn ?? this.isSingleFlipOn,
      solutionsNumber: solutionsNumber ?? this.solutionsNumber,
      canUseSolution: canUseSolution ?? this.canUseSolution,
      isSolutionOn: isSolutionOn ?? this.isSolutionOn,
      fieldLength: fieldLength ?? this.fieldLength,
      cells: cells ?? this.cells,
      cellsToFlip: cellsToFlip ??
          List<bool>.generate(this.cells.length, (index) => false),
      flashCellIndex: flashCellIndex ?? -1,
      isWin: isWin ?? false,
      isEndTutorial: isEndTutorial ?? false,
    );
  }

  // @override
  // String toString() {
  //   return 'showIntroTutoriaDialog: \n
  //   this.showSolutionTutoriaDialog: \n
  //   this.solutionUsed: \n
  //   this.levelId: \n
  //   this.nextLevelId: \n
  //   this.levelNumber: \n
  //   this.moves: \n
  //   this.singleFlips: \n
  //   this.canUseSingleFlips: \n
  //   this.isSingleFlipOn: \n
  //   this.solutionsNumber: \n
  //   this.canUseSolution: \n
  //   this.isSolutionOn: \n
  //   this.fieldLength: \n
  //   this.cells = const [],
  //   this.cellsToFlip = const [],
  //   this.flashCellIndex = -1,
  //   this.isWin = false,
  //   this.isEndTutorial = false,';
  // }
}
