class TutorialPrefsModel {
  late bool intro;
  late bool singleFlips;
  late bool solutions;

  TutorialPrefsModel({
    required this.intro,
    required this.singleFlips,
    required this.solutions,
  });

  TutorialPrefsModel.fromJson(Map<String, dynamic> json)
      : intro = json['intro'] as bool,
        singleFlips = json['singleFlips'] as bool,
        solutions = json['solutions'] as bool;

  Map<String, dynamic> toJson() => {
        'intro': intro,
        'singleFlips': singleFlips,
        'solutions': solutions,
      };
}
