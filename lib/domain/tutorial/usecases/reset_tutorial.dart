import 'package:darkit/domain/tutorial/entities/tutorial_entity.dart';
import 'package:darkit/domain/tutorial/repositories/tutorial_repository.dart';

class ResetTutorial {
  final TutorialRepository _tutorialRepository;
  ResetTutorial(this._tutorialRepository);
  Future<void> call() async {
    final TutorialEntity _newTutorial = TutorialEntity(
      intro: false,
      singleFlips: false,
      solutions: false,
    );
    await _tutorialRepository.save(_newTutorial);
  }
}
