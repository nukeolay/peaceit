import 'package:peaceit/domain/hints/entities/hints_entity.dart';
import 'package:peaceit/domain/hints/repositories/hints_repository.dart';

class SingleFlipsDecrement {
  final HintsRepository _hintsRepository;
  SingleFlipsDecrement(this._hintsRepository);
  Future<void> call() async {
    final HintsEntity _hints = _hintsRepository.hints;
    final HintsEntity _newHints = _hints.copyWith(
        singleFlips: _hints.singleFlips - 1 >= 0 ? _hints.singleFlips - 1 : 0);
    await _hintsRepository.save(_newHints);
  }
}
