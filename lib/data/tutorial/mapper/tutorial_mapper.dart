import 'package:darkit/domain/tutorial/entities/tutorial_entity.dart';
import 'package:darkit/data/tutorial/prefs/model/tutorial_prefs_model.dart';

class TutorialMapper {
  static TutorialEntity fromPrefs(TutorialPrefsModel tutorialPrefsModel) {
    return TutorialEntity(
      intro: tutorialPrefsModel.intro,
      singleFlips: tutorialPrefsModel.singleFlips,
      solutions: tutorialPrefsModel.solutions,
    );
  }

  static TutorialPrefsModel toPrefs(TutorialEntity tutorial) {
    return TutorialPrefsModel(
      intro: tutorial.intro,
      singleFlips: tutorial.singleFlips,
      solutions: tutorial.solutions,
    );
  }
}
