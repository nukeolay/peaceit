import 'package:peaceit/domain/hints/entities/hints_entity.dart';

abstract class HintsRepository {
  HintsEntity get hints;
  Future<void> load();
  Future<void> save(HintsEntity hints);
}
