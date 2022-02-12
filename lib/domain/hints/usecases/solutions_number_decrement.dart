import 'package:darkit/domain/hints/entities/hints_entity.dart';
import 'package:darkit/domain/hints/repositories/hints_repository.dart';

class SolutionsNumberDecrement {
  final HintsRepository _hintsRepository;
  SolutionsNumberDecrement(this._hintsRepository);
  Future<void> call() async {
    final HintsEntity _hints = _hintsRepository.hints;
    final HintsEntity _newHints = _hints.copyWith(
        solutionsNumber:
            _hints.solutionsNumber - 1 >= 0 ? _hints.solutionsNumber - 1 : 0);
    await _hintsRepository.save(_newHints);
  }
}
