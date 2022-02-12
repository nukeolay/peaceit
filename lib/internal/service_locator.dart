import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:darkit/features/hints/data/prefs/hints_prefs_util.dart';
import 'package:darkit/features/hints/data/prefs/services/hints_prefs_service.dart';
import 'package:darkit/features/hints/data/repositories/hints_repository_impl.dart';
import 'package:darkit/features/hints/domain/repositories/hints_repository.dart';
import 'package:darkit/features/hints/domain/usecases/reset_hints.dart';
import 'package:darkit/features/hints/domain/usecases/single_flips_decrement.dart';
import 'package:darkit/features/hints/domain/usecases/single_flips_increment.dart';
import 'package:darkit/features/hints/domain/usecases/solutions_number_decrement.dart';
import 'package:darkit/features/hints/domain/usecases/solutions_number_increment.dart';
import 'package:darkit/features/levels/data/prefs/levels_prefs_util.dart';
import 'package:darkit/features/levels/data/prefs/services/levels_prefs_service.dart';
import 'package:darkit/features/levels/data/repositories/levels_repository_impl.dart';
import 'package:darkit/features/levels/domain/repositories/levels_repository.dart';
import 'package:darkit/features/levels/domain/usecases/get_chapers.dart';
import 'package:darkit/features/levels/domain/usecases/get_levels.dart';
import 'package:darkit/features/levels/domain/usecases/reset_levels.dart';

final GetIt serviceLocator = GetIt.instance;

Future<void> init() async {
  // BLoC / Cubit
  // serviceLocator.registerFactory(
  //   () => PersonListCubit(getAllPersons: serviceLocator()),
  // );
  // serviceLocator.registerFactory(
  //   () => PersonSearchBloc(searchPerson: serviceLocator()),
  // );

  // ---UseCases---
  // Hints
  serviceLocator.registerLazySingleton<ResetHints>(
    () => ResetHints(serviceLocator()),
  );
  serviceLocator.registerLazySingleton<SingleFlipsDecrement>(
    () => SingleFlipsDecrement(serviceLocator()),
  );
  serviceLocator.registerLazySingleton<SingleFlipsIncrement>(
    () => SingleFlipsIncrement(serviceLocator()),
  );
  serviceLocator.registerLazySingleton<SolutionsNumberDecrement>(
    () => SolutionsNumberDecrement(serviceLocator()),
  );
  serviceLocator.registerLazySingleton<SolutionsNumberIncrement>(
    () => SolutionsNumberIncrement(serviceLocator()),
  );

  // Levels
  serviceLocator.registerLazySingleton<ResetLevels>(
    () => ResetLevels(serviceLocator()),
  );
  serviceLocator.registerLazySingleton<GetChapters>(
    () => GetChapters(serviceLocator()),
  );
  serviceLocator.registerLazySingleton<GetLevels>(
    () => GetLevels(serviceLocator()),
  );

  // ---Repository---
  // HintsRepository
  serviceLocator.registerLazySingleton<HintsRepository>(
    () => HintsRepositoryImpl(serviceLocator()),
  );
  serviceLocator.registerLazySingleton<HintsPrefsUtil>(
    () => HintsPrefsUtil(serviceLocator()),
  );
  serviceLocator.registerLazySingleton<HintsPrefsService>(
    () => HintsPrefsService(serviceLocator()),
  );

  // LevelsRepository
  serviceLocator.registerLazySingleton<LevelsRepository>(
    () => LevelsRepositoryImpl(serviceLocator()),
  );
  serviceLocator.registerLazySingleton<LevelsPrefsUtil>(
    () => LevelsPrefsUtil(serviceLocator()),
  );
  serviceLocator.registerLazySingleton<LevelsPrefsService>(
    () => LevelsPrefsService(serviceLocator()),
  );

  // ---Core---
  // empty

  // ---External---
  final SharedPreferences sharedPreferences =
      await SharedPreferences.getInstance();
  serviceLocator
      .registerLazySingleton<SharedPreferences>(() => sharedPreferences);

  // -- Repositories Init --
  await serviceLocator<LevelsRepository>().load();
  await serviceLocator<HintsRepository>().load();
}
