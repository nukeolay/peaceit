import 'package:darkit/domain/hints/entities/hints_entity.dart';
import 'package:darkit/domain/hints/repositories/hints_repository.dart';

class UpdateHints {
  final HintsRepository _hintsRepository;
  UpdateHints(this._hintsRepository);
  Future<HintsEntity> call({int? singleFlips, int? solutionsNumber}) async {
    final HintsEntity _hints = _hintsRepository.hints;
    final HintsEntity _newHints = _hints.copyWith(
        singleFlips: singleFlips ?? _hints.singleFlips,
        solutionsNumber: solutionsNumber ?? _hints.solutionsNumber);
    await _hintsRepository.save(_newHints);
    return _newHints;
  }
}
