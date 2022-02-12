class HintsEntity {
  final int singleFlips;
  final int solutionsNumber;

  HintsEntity({
    required this.singleFlips,
    required this.solutionsNumber,
  });

  HintsEntity copyWith({
    int? singleFlips,
    int? solutionsNumber,
  }) {
    return HintsEntity(
      singleFlips: singleFlips ?? this.singleFlips,
      solutionsNumber: solutionsNumber ?? this.solutionsNumber,
    );
  }

  @override
  String toString() {
    return 'HINTS:\n -singleFlips: $singleFlips,\n -solutionsNumber: $solutionsNumber';
  }
}
