import 'package:peaceit/domain/tutorial/entities/tutorial_entity.dart';
import 'package:peaceit/domain/tutorial/repositories/tutorial_repository.dart';

class UpdateTutorial {
  final TutorialRepository _tutorialRepository;
  UpdateTutorial(this._tutorialRepository);
  Future<TutorialEntity> call(
      {bool? intro, bool? singleFlips, bool? solutions}) async {
    final TutorialEntity _tutorial = _tutorialRepository.tutorial;
    final TutorialEntity _newTutorial = _tutorial.copyWith(
      intro: intro ?? _tutorial.intro,
      singleFlips: singleFlips ?? _tutorial.singleFlips,
      solutions: solutions ?? _tutorial.solutions,
    );
    await _tutorialRepository.save(_newTutorial);
    return _newTutorial;
  }
}
