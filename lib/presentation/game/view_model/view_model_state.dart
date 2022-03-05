import 'package:peaceit/domain/levels/entities/chapter_entity.dart';

class GameViewModelState {
  final ChapterEntity chapter;
  final String levelId;
  final bool isBoss;
  final String levelNumber;
  final String moves;
  final String singleFlips;
  final bool canUseSingleFlips;
  final bool isSingleFlipOn;
  final String solutionsNumber;
  final bool canUseSolution;
  final bool isSolutionOn;
  final bool showTutorialIntro;
  final bool showTutorialSingleFlips;
  final bool showTutorialSolutions;
  final bool flashSingleFlips;
  final bool flashSolutions;
  final bool isTutorialIntroShown;
  final bool isTutorialSingleFlipsShown;
  final bool isTutorialSolutionsShown;
  final int fieldLength;
  final List<bool> cells;
  final List<bool> cellsToFlip;
  final int flashCellIndex;
  final bool isWin;

  GameViewModelState({
    required this.chapter,
    this.levelId = '',
    this.isBoss = false,
    this.levelNumber = '',
    this.moves = '0',
    this.singleFlips = '',
    this.canUseSingleFlips = false,
    this.isSingleFlipOn = false,
    this.solutionsNumber = '',
    this.canUseSolution = false,
    this.isSolutionOn = false,
    this.showTutorialIntro = false,
    this.showTutorialSingleFlips = false,
    this.showTutorialSolutions = false,
    this.flashSingleFlips = false,
    this.flashSolutions = false,
    this.isTutorialIntroShown = false,
    this.isTutorialSingleFlipsShown = false,
    this.isTutorialSolutionsShown = false,
    this.fieldLength = 0,
    this.cells = const [],
    this.cellsToFlip = const [],
    this.flashCellIndex = -1,
    this.isWin = false,
  });

  GameViewModelState copyWith({
    String? levelId,
    bool? isBoss,
    String? levelNumber,
    String? moves,
    String? singleFlips,
    bool? canUseSingleFlips,
    bool? isSingleFlipOn,
    String? solutionsNumber,
    bool? canUseSolution,
    bool? isSolutionOn,
    bool? showTutorialIntro,
    bool? showTutorialSingleFlips,
    bool? showTutorialSolutions,
    bool? flashSingleFlips,
    bool? flashSolutions,
    bool? isTutorialIntroShown,
    bool? isTutorialSingleFlipsShown,
    bool? isTutorialSolutionsShown,
    int? fieldLength,
    List<bool>? cells,
    List<bool>? cellsToFlip,
    int? flashCellIndex,
    bool? isWin,
  }) {
    return GameViewModelState(
      chapter: chapter,
      levelId: levelId ?? this.levelId,
      isBoss: isBoss ?? this.isBoss,
      levelNumber: levelNumber ?? this.levelNumber,
      moves: moves ?? this.moves,
      singleFlips: singleFlips ?? this.singleFlips,
      canUseSingleFlips: canUseSingleFlips ?? this.canUseSingleFlips,
      isSingleFlipOn: isSingleFlipOn ?? this.isSingleFlipOn,
      solutionsNumber: solutionsNumber ?? this.solutionsNumber,
      canUseSolution: canUseSolution ?? this.canUseSolution,
      isSolutionOn: isSolutionOn ?? this.isSolutionOn,
      showTutorialIntro: showTutorialIntro ?? this.showTutorialIntro,
      showTutorialSingleFlips:
          showTutorialSingleFlips ?? this.showTutorialSingleFlips,
      showTutorialSolutions:
          showTutorialSolutions ?? this.showTutorialSolutions,
      flashSingleFlips: flashSingleFlips ?? this.flashSingleFlips,
      flashSolutions: flashSolutions ?? this.flashSolutions,
      isTutorialIntroShown: isTutorialIntroShown ?? this.isTutorialIntroShown,
      isTutorialSingleFlipsShown:
          isTutorialSingleFlipsShown ?? this.isTutorialSingleFlipsShown,
      isTutorialSolutionsShown:
          isTutorialSolutionsShown ?? this.isTutorialSolutionsShown,
      fieldLength: fieldLength ?? this.fieldLength,
      cells: cells ?? this.cells,
      cellsToFlip: cellsToFlip ??
          List<bool>.generate(this.cells.length, (index) => false),
      flashCellIndex: flashCellIndex ?? -1,
      isWin: isWin ?? false,
    );
  }
}
