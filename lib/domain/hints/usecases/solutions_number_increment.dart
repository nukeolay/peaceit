import 'package:darkit/domain/hints/entities/hints_entity.dart';
import 'package:darkit/domain/hints/repositories/hints_repository.dart';

class SolutionsNumberIncrement {
  final HintsRepository _hintsRepository;
  SolutionsNumberIncrement(this._hintsRepository);
  Future<void> call() async {
    final HintsEntity _hints = _hintsRepository.hints;
    final HintsEntity _newHints =
        _hints.copyWith(solutionsNumber: _hints.solutionsNumber + 1);
    await _hintsRepository.save(_newHints);
  }
}
