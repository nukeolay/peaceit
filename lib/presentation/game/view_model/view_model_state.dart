import 'package:darkit/domain/levels/entities/chapter_entity.dart';

class GameViewModelState {
  final ChapterEntity chapter;
  final String levelId;
  final String levelNumber;
  final String moves;
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

  GameViewModelState({
    required this.chapter,
    this.levelId = '',
    this.levelNumber = '',
    this.moves = '0',
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
  });

  GameViewModelState copyWith({
    String? levelId,
    String? levelNumber,
    String? moves,
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
  }) {
    return GameViewModelState(
      chapter: chapter,
      levelId: levelId ?? this.levelId,
      levelNumber: levelNumber ?? this.levelNumber,
      moves: moves ?? this.moves,
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
    );
  }
}
