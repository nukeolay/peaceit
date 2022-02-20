class LevelCompletedViewModelState {
  final String levelId;
  final String nextLevelId;
  final int rating;
  final int moves;
  final int bestResult;
  final bool isSingleFlipAdded;
  final bool isSolutionAdded;
  final bool isNewChapterOpened;
  final bool isEndChapter;
  final bool isEndGame;

  LevelCompletedViewModelState({
    this.levelId = '',
    this.nextLevelId = '',
    this.rating = 0,
    this.moves = 0,
    this.bestResult = 0,
    this.isSingleFlipAdded = false,
    this.isSolutionAdded = false,
    this.isNewChapterOpened = false,
    this.isEndChapter = false,
    this.isEndGame = false,
  });

  LevelCompletedViewModelState copyWith({
    String? levelId,
    String? nextLevelId,
    int? rating,
    int? moves,
    int? bestResult,
    bool? isSingleFlipAdded,
    bool? isSolutionAdded,
    bool? isNewChapterOpened,
    bool? isEndChapter,
    bool? isEndGame,
  }) {
    return LevelCompletedViewModelState(
      levelId: levelId ?? this.levelId,
      nextLevelId: nextLevelId ?? this.levelId,
      rating: rating ?? this.rating,
      moves: moves ?? this.moves,
      isSingleFlipAdded: isSingleFlipAdded ?? this.isSingleFlipAdded,
      isSolutionAdded: isSolutionAdded ?? this.isSolutionAdded,
      bestResult: bestResult ?? this.bestResult,
      isNewChapterOpened: isNewChapterOpened ?? this.isNewChapterOpened,
      isEndChapter: isEndChapter ?? this.isEndGame,
      isEndGame: isEndGame ?? this.isEndGame,
    );
  }
}
