import 'package:darkit/domain/entities/user_data.dart';
import 'package:darkit/data/prefs/model/user_data_prefs_model.dart';

class DataUserMapper {
  static UserData fromPrefs(UserDataPrefsModel userDataPrefsModel) {
    return UserData(
      completedLevels: userDataPrefsModel.completedLevels.map(
        (id, value) => MapEntry(
          id,
          CompletedLevel(id: id, rating: value['rating'] as int),
        ),
      ),
      singleFlips: userDataPrefsModel.singleFlips,
      solutionsNumber: userDataPrefsModel.solutionsNumber,
    );
  }

  static UserDataPrefsModel toPrefs(UserData userData) {
    return UserDataPrefsModel(
      completedLevels: userData.completedLevels,
      singleFlips: userData.singleFlips,
      solutionsNumber: userData.solutionsNumber,
    );
  }
}
