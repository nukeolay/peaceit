import 'package:peaceit/data/hints/prefs/model/hints_prefs_model.dart';
import 'package:peaceit/domain/hints/entities/hints_entity.dart';

class HintsMapper {
  static HintsEntity fromPrefs(HintsPrefsModel hintsPrefsModel) {
    return HintsEntity(
      singleFlips: hintsPrefsModel.singleFlips,
      solutionsNumber: hintsPrefsModel.solutionsNumber,
    );
  }

  static HintsPrefsModel toPrefs(HintsEntity hints) {
    return HintsPrefsModel(
      singleFlips: hints.singleFlips,
      solutionsNumber: hints.solutionsNumber,
    );
  }
}
