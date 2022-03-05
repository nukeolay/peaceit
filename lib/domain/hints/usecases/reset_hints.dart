import 'package:peaceit/core/constants/default_game_settings.dart';
import 'package:peaceit/domain/hints/entities/hints_entity.dart';
import 'package:peaceit/domain/hints/repositories/hints_repository.dart';

class ResetHints {
  final HintsRepository _hintsRepository;
  ResetHints(this._hintsRepository);
  Future<void> call() async {
    final HintsEntity _hints = _hintsRepository.hints;
    final HintsEntity _newHints = _hints.copyWith(
        singleFlips: DefaultGameSettings.singleFlips,
        solutionsNumber: DefaultGameSettings.solutionsNumber);
    await _hintsRepository.save(_newHints);
  }
}
