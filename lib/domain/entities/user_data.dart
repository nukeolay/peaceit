class UserData {
  Map<String, CompletedLevel> completedLevels;
  int singleFlips;
  int solutionsNumber;

  UserData({
    required this.completedLevels,
    required this.singleFlips,
    required this.solutionsNumber,
  });

  // completedLevels methods

  bool isLevelCompleted(String levelId) {
    return completedLevels.keys.contains(levelId);
  }

  void setCompletedLevel(CompletedLevel completedLevel) {
    completedLevels[completedLevel.id] = completedLevel;
  }
}

class CompletedLevel {
  String id;
  int rating;

  CompletedLevel({
    required this.id,
    required this.rating,
  });

  @override
  String toString() {
    return 'ID: $id, RATING: $rating';
  }
}
