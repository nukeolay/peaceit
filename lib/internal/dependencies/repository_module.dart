import 'package:darkit/data/repositories/user_data_repository_impl.dart';
import 'package:darkit/domain/repositories/user_data_repository.dart';
import 'package:darkit/internal/dependencies/prefs_module.dart';

class RepositoryModule {
  static UserDataRepository? _userDataRepository;

  static UserDataRepository get userDataRepository {
    _userDataRepository ??= UserDataRepositoryImpl(
      PrefsModule.prefsUtil,
    );
    return _userDataRepository!;
  }
}
