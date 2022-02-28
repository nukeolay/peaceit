class TutorialEntity {
  final bool intro;
  final bool singleFlips;
  final bool solutions;

  TutorialEntity({
    required this.intro,
    required this.singleFlips,
    required this.solutions,
  });

  TutorialEntity copyWith({
    bool? intro,
    bool? singleFlips,
    bool? solutions,
  }) {
    return TutorialEntity(
      intro: intro ?? this.intro,
      singleFlips: singleFlips ?? this.singleFlips,
      solutions: solutions ?? this.solutions,
    );
  }

  @override
  String toString() {
    return 'intro: $intro, singleFlips: $singleFlips, solutions: $solutions';
  }
}
