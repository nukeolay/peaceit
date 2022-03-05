import 'package:peaceit/domain/tutorial/entities/tutorial_entity.dart';

abstract class TutorialRepository {
  TutorialEntity get tutorial;
  Future<void> load();
  Future<void> save(TutorialEntity tutorial);
}
