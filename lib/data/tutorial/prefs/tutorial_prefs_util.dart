import 'package:peaceit/data/tutorial/mapper/tutorial_mapper.dart';
import 'package:peaceit/data/tutorial/prefs/model/tutorial_prefs_model.dart';
import 'package:peaceit/data/tutorial/prefs/services/tutorial_prefs_service.dart';
import 'package:peaceit/domain/tutorial/entities/tutorial_entity.dart';

class TutorialPrefsUtil {
  final TutorialPrefsService _prefsTutorialService;

  TutorialPrefsUtil(this._prefsTutorialService);

  Future<TutorialEntity> load() async {
    final TutorialPrefsModel result = await _prefsTutorialService.load();
    return TutorialMapper.fromPrefs(result);
  }

  Future<void> save(TutorialEntity tutorial) async {
    return await _prefsTutorialService.save(TutorialMapper.toPrefs(tutorial));
  }
}
