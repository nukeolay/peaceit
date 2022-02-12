class HintsPrefsModel {
  late int singleFlips;
  late int solutionsNumber;

  HintsPrefsModel({
    required this.singleFlips,
    required this.solutionsNumber,
  });

  HintsPrefsModel.fromJson(Map<String, dynamic> json)
      : singleFlips = json['singleFlips'] as int,
        solutionsNumber = json['solutionsNumber'] as int;

  Map<String, dynamic> toJson() => {
        'singleFlips': singleFlips,
        'solutionsNumber': solutionsNumber,
      };
}
