import 'package:darkit/domain/tutorial/entities/tutorial_entity.dart';
import 'package:darkit/domain/tutorial/repositories/tutorial_repository.dart';

class GetTutorial {
  final TutorialRepository _tutorialRepository;
  GetTutorial(this._tutorialRepository);
  TutorialEntity call() {
    return _tutorialRepository.tutorial;
  }
}
