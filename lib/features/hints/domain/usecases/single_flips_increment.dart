import 'package:darkit/features/hints/domain/entities/hints_entity.dart';
import 'package:darkit/features/hints/domain/repositories/hints_repository.dart';

class SingleFlipsIncrement {
  final HintsRepository _hintsRepository;
  SingleFlipsIncrement(this._hintsRepository);
  Future<void> call() async {
    final HintsEntity _hints = _hintsRepository.hints;
    final HintsEntity _newHints =
        _hints.copyWith(singleFlips: _hints.singleFlips + 1);
    await _hintsRepository.save(_newHints);
  }
}
