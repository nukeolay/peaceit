import 'package:darkit/features/hints/data/mapper/hints_mapper.dart';
import 'package:darkit/features/hints/data/prefs/model/hints_prefs_model.dart';
import 'package:darkit/features/hints/data/prefs/services/hints_prefs_service.dart';
import 'package:darkit/features/hints/domain/entities/hints_entity.dart';

class HintsPrefsUtil {
  final HintsPrefsService _prefsHintsService;

  HintsPrefsUtil(this._prefsHintsService);

  Future<HintsEntity> load() async {
    final HintsPrefsModel result = await _prefsHintsService.load();
    return HintsMapper.fromPrefs(result);
  }

  Future<void> save(HintsEntity hints) async {
    return await _prefsHintsService.save(HintsMapper.toPrefs(hints));
  }
}
