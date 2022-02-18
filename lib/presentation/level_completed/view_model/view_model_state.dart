class LevelCompletedViewModelState {
  final String levelId;
  final String nextLevelId;
  final int rating;
  final int moves;
  final int bestResult;
  final bool isNewChapterOpened;
  final bool isEndGame;

  LevelCompletedViewModelState({
    this.levelId = '',
    this.nextLevelId = '',
    this.rating = 0,
    this.moves = 0,
    this.bestResult = 0,
    this.isNewChapterOpened = false,
    this.isEndGame = false,
  });

  LevelCompletedViewModelState copyWith({
    String? levelId,
    String? nextLevelId,
    int? rating,
    int? moves,
    int? bestResult,
    bool? isNewChapterOpened,
    bool? isEndGame,
  }) {
    return LevelCompletedViewModelState(
      levelId: levelId ?? this.levelId,
      nextLevelId: nextLevelId ?? this.levelId,
      rating: rating ?? this.rating,
      moves: moves ?? this.moves,
      bestResult: bestResult ?? this.bestResult,
      isNewChapterOpened: isNewChapterOpened ?? this.isNewChapterOpened,
      isEndGame: isEndGame ?? this.isEndGame,
    );
  }
}
