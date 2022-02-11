class SelectChapterViewModelState {
  final List<String> chapters;
  final int chaptersNumber;
  final List<double> completedRatio;
  final List<String> completedLevels;
  final List<String> levelsNumber;
  final List<bool> canBePlayed;

  SelectChapterViewModelState({
    this.chapters = const [],
    this.chaptersNumber = 0,
    this.completedRatio = const [],
    this.completedLevels = const [],
    this.levelsNumber = const [],
    this.canBePlayed = const [],
  });

  @override
  SelectChapterViewModelState copyWith({
    List<String>? chapters,
    int? chaptersNumber,
    List<double>? completedRatio,
    List<String>? completedLevels,
    List<String>? levelsNumber,
    List<bool>? canBePlayed,
  }) {
    return SelectChapterViewModelState(
      chapters: chapters ?? this.chapters,
      chaptersNumber: chaptersNumber ?? this.chaptersNumber,
      completedRatio: completedRatio ?? this.completedRatio,
      completedLevels: completedLevels ?? this.completedLevels,
      levelsNumber: levelsNumber ?? this.levelsNumber,
      canBePlayed: canBePlayed ?? this.canBePlayed,
    );
  }
}