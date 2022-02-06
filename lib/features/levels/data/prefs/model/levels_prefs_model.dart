class LevelsPrefsModel {
  late Map<String, int> completedLevels;

  LevelsPrefsModel({
    required this.completedLevels,
  });

  LevelsPrefsModel.fromJson(Map<String, dynamic> json)
      : completedLevels = json['completedLevels'] as Map<String, int>;

  Map<String, dynamic> toJson() => {
        'completedLevels': completedLevels,
      };
}
