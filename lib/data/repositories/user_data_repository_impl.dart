import 'package:darkit/domain/entities/user_data.dart';
import 'package:darkit/data/prefs/prefs_util.dart';
import 'package:darkit/domain/repositories/user_data_repository.dart';

class UserDataRepositoryImpl implements UserDataRepository {
  final PrefsUtil _prefsUtil;
  UserData _userData = UserData(
    completedLevels: {},
    singleFlips: 2,
    solutionsNumber: 2,
  );

  UserDataRepositoryImpl(this._prefsUtil);

  @override
  UserData get userData => _userData;

  @override
  Future<void> load() async {
    _userData = await _prefsUtil.load();
  }

  @override
  Future<void> save() async {
    return _prefsUtil.save(userData);
  }
}
