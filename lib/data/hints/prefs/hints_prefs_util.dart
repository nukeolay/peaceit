import 'package:darkit/data/hints/mapper/hints_mapper.dart';
import 'package:darkit/data/hints/prefs/model/hints_prefs_model.dart';
import 'package:darkit/data/hints/prefs/services/hints_prefs_service.dart';
import 'package:darkit/domain/hints/entities/hints_entity.dart';

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
