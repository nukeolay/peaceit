class LevelsPrefsModel {
  late Map<String, int> completedLevels;
  
  LevelsPrefsModel({
    required this.completedLevels,
  });

  LevelsPrefsModel.fromJson(Map<String, dynamic> json)
      : completedLevels = json.map((key, value) => MapEntry(key, value as int));

  Map<String, dynamic> toJson() => completedLevels;
}
