import 'package:darkit/features/levels/domain/entities/levels_entity.dart';

abstract class LevelsRepository {
  LevelsEntity get levels;
  Future<void> load();
  Future<void> save(LevelsEntity levels);
}
