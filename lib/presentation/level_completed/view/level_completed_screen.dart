import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import 'package:darkit/core/routes/routes.dart';
import 'package:darkit/core/utils/utils.dart';
import 'package:darkit/core/theme/app_theme.dart';
import 'package:darkit/presentation/level_completed/view_model/view_model.dart';

class LevelCompletedScreen extends StatelessWidget {
  const LevelCompletedScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _arguments =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    final _levelId = _arguments['levelId'] as String;
    final _moves = int.parse(_arguments['moves'] as String);

    return ChangeNotifierProvider(
      create: (_) => LevelCompletedViewModel(_levelId, _moves),
      builder: (context, _) {
        final _viewModel = context.read<LevelCompletedViewModel>();
        final _state = _viewModel.state;

        return Scaffold(
          body: Container(
            width: double.infinity,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/bg.png'),
                fit: BoxFit.cover,
              ),
            ),
            child: SafeArea(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    RatingRow(rating: _state.rating),
                    if (_state.isSolutionAdded)
                      const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          '+1 решение',
                          style: TextStyle(fontSize: 22),
                        ),
                      ),
                    if (_state.isSingleFlipAdded)
                      const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          '+1 одиночный поворот',
                          style: TextStyle(fontSize: 22),
                        ),
                      ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'уровень пройден за ${_state.moves} ${Utils.wordEnding(_state.moves)}',
                        style: const TextStyle(fontSize: 16),
                      ),
                    ),
                    if (_state.rating != 3)
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8.0),
                        child: BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
                          child: Container(
                            padding: const EdgeInsets.all(8.0),
                            decoration: BoxDecoration(
                              color: context
                                  .read<AppTheme>()
                                  .cardBack
                                  .withOpacity(0.1),
                              boxShadow: [
                                BoxShadow(
                                  color: context
                                      .read<AppTheme>()
                                      .cardBack
                                      .withOpacity(0.05),
                                  blurRadius: 6.0,
                                ),
                              ],
                            ),
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8.0),
                              child: Text(
                                'чтобы получить 3 звезды,\nпройди этот уровень за ${_state.bestResult} ${Utils.wordEnding(_state.bestResult)}',
                                textAlign: TextAlign.center,
                                style: const TextStyle(fontSize: 16),
                              ),
                            ),
                          ),
                        ),
                      ),
                    const SizedBox(height: 30),
                    // TODO проверять, если закончено более 70% в главе, писать, что открыта новая глава
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IconButton(
                          onPressed: () {
                            HapticFeedback.heavyImpact();
                            Navigator.of(context).pushReplacementNamed(
                              Routes.game,
                              arguments: _levelId,
                            );
                          },
                          icon: const Icon(
                            Icons.replay_rounded,
                            size: 40,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(
                          width: 100,
                        ),
                        IconButton(
                          onPressed: () {
                            HapticFeedback.heavyImpact();
                            if (_state.isEndGame) {
                              Navigator.of(context)
                                  .pushReplacementNamed(Routes.gameFinished);
                            } else {
                              try {
                                Navigator.of(context).pushReplacementNamed(
                                    Routes.game,
                                    arguments: _state.nextLevelId);
                              } catch (error) {
                                Navigator.popUntil(
                                  context,
                                  ModalRoute.withName(Routes.selectChapterMenu),
                                );
                              }
                            }
                          },
                          icon: const Icon(
                            Icons.arrow_forward_ios_rounded,
                            size: 40,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class RatingRow extends StatelessWidget {
  const RatingRow({
    Key? key,
    required this.rating,
  }) : super(key: key);

  final int rating;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          Icons.star_rounded,
          color: context.read<AppTheme>().accentColor,
          size: 36,
        ),
        Icon(
          rating >= 2 ? Icons.star_rounded : Icons.star_outline_rounded,
          color: context.read<AppTheme>().accentColor,
          size: 36,
        ),
        Icon(
          rating == 3 ? Icons.star_rounded : Icons.star_outline_rounded,
          color: context.read<AppTheme>().accentColor,
          size: 36,
        ),
      ],
    );
  }
}
