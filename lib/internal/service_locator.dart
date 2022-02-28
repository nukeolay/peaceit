import 'package:darkit/domain/hints/usecases/update_hints.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:darkit/data/hints/prefs/hints_prefs_util.dart';
import 'package:darkit/data/hints/prefs/services/hints_prefs_service.dart';
import 'package:darkit/data/hints/repositories/hints_repository_impl.dart';
import 'package:darkit/domain/hints/repositories/hints_repository.dart';
import 'package:darkit/domain/hints/usecases/reset_hints.dart';
import 'package:darkit/domain/hints/usecases/single_flips_decrement.dart';
import 'package:darkit/domain/hints/usecases/single_flips_increment.dart';
import 'package:darkit/domain/hints/usecases/solutions_number_decrement.dart';
import 'package:darkit/domain/hints/usecases/solutions_number_increment.dart';
import 'package:darkit/data/levels/prefs/levels_prefs_util.dart';
import 'package:darkit/data/levels/prefs/services/levels_prefs_service.dart';
import 'package:darkit/data/levels/repositories/levels_repository_impl.dart';
import 'package:darkit/domain/levels/repositories/levels_repository.dart';
import 'package:darkit/domain/levels/usecases/get_chapers.dart';
import 'package:darkit/domain/levels/usecases/get_levels.dart';
import 'package:darkit/domain/levels/usecases/reset_levels.dart';
import 'package:darkit/domain/levels/usecases/complete_level.dart';
import 'package:darkit/data/tutorial/repositories/tutorial_repository_impl.dart';
import 'package:darkit/domain/tutorial/repositories/tutorial_repository.dart';
import 'package:darkit/data/tutorial/prefs/services/tutorial_prefs_service.dart';
import 'package:darkit/data/tutorial/prefs/tutorial_prefs_util.dart';
import 'package:darkit/domain/tutorial/usecases/update_tutorial.dart';
import 'package:darkit/domain/tutorial/usecases/get_tutorial.dart';
import 'package:darkit/domain/tutorial/usecases/reset_tutorial.dart';

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
  serviceLocator.registerLazySingleton<UpdateHints>(
    () => UpdateHints(serviceLocator()),
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

  serviceLocator.registerLazySingleton<CompleteLevel>(
    () => CompleteLevel(serviceLocator()),
  );

  // Tutorial
  serviceLocator.registerLazySingleton<GetTutorial>(
    () => GetTutorial(serviceLocator()),
  );
  serviceLocator.registerLazySingleton<UpdateTutorial>(
    () => UpdateTutorial(serviceLocator()),
  );
  serviceLocator.registerLazySingleton<ResetTutorial>(
    () => ResetTutorial(serviceLocator()),
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

  // TutorialRepository
  serviceLocator.registerLazySingleton<TutorialRepository>(
    () => TutorialRepositoryImpl(serviceLocator()),
  );
  serviceLocator.registerLazySingleton<TutorialPrefsUtil>(
    () => TutorialPrefsUtil(serviceLocator()),
  );
  serviceLocator.registerLazySingleton<TutorialPrefsService>(
    () => TutorialPrefsService(serviceLocator()),
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
  await serviceLocator<TutorialRepository>().load();
}
