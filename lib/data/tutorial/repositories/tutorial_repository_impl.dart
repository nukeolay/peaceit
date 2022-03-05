import 'package:peaceit/data/tutorial/prefs/tutorial_prefs_util.dart';
import 'package:peaceit/domain/tutorial/entities/tutorial_entity.dart';
import 'package:peaceit/domain/tutorial/repositories/tutorial_repository.dart';

class TutorialRepositoryImpl implements TutorialRepository {
  final TutorialPrefsUtil _prefsTutorialUtil;
  late TutorialEntity _tutorial;

  TutorialRepositoryImpl(this._prefsTutorialUtil);

  @override
  TutorialEntity get tutorial => _tutorial;

  @override
  Future<void> load() async {
    try {
      _tutorial = await _prefsTutorialUtil.load();
    } catch (_) {
      _tutorial = TutorialEntity(
        intro: false,
        singleFlips: false,
        solutions: false,
      );
    }
  }

  @override
  Future<void> save(TutorialEntity tutorial) {
    _tutorial = tutorial;
    return _prefsTutorialUtil.save(tutorial);
  }
}
