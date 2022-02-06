// import 'package:darkit/domain/entities/user_data.dart';

import 'package:darkit/domain/entities/user_data.dart';

class UserDataPrefsModel {
  late Map<String, dynamic> completedLevels;
  late int singleFlips;
  late int solutionsNumber;

  UserDataPrefsModel({
    required this.completedLevels,
    required this.singleFlips,
    required this.solutionsNumber,
  });

  UserDataPrefsModel.fromJson(Map<String, dynamic> json)
      : completedLevels = json['completedLevels'] as Map<String, dynamic>,
        singleFlips = json['singleFlips'] as int,
        solutionsNumber = json['solutionsNumber'] as int;

  Map<String, dynamic> toJson() => {
        'completedLevels': completedLevels.map(
          (id, value) => MapEntry(
            id,
            {'id': id, 'rating': (value as CompletedLevel).rating},
            // {'id': id, 'rating': value['rating']},
          ),
        ),
        'singleFlips': singleFlips,
        'solutionsNumber': solutionsNumber,
      };
}
