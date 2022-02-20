import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import 'package:darkit/core/routes/routes.dart';
import 'package:darkit/core/utils/utils.dart';
import 'package:darkit/core/theme/app_theme.dart';
import 'package:darkit/presentation/level_completed/view_model/view_model.dart';
import 'package:darkit/presentation/level_completed/view/widgets/info_card.dart';
import 'package:darkit/presentation/level_completed/view/widgets/rating_row.dart';

class LevelCompletedScreen extends StatelessWidget {
  const LevelCompletedScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration.zero).then((_) {
      precacheImage(const AssetImage('assets/bg.png'), context);
    });
    final _arguments =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    final _levelId = _arguments['levelId'] as String;
    final _moves = int.parse(_arguments['moves'] as String);

    return ChangeNotifierProvider(
      create: (_) => LevelCompletedViewModel(_levelId, _moves),
      builder: (context, _) {
        final _viewModel = context.read<LevelCompletedViewModel>();
        final _state = _viewModel.state;
        return WillPopScope(
          onWillPop: () {
            Navigator.popUntil(
                context, ModalRoute.withName(Routes.selectLevelMenu));
            return Future.value(true);
          },
          child: Scaffold(
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
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'уровень пройден за ${_state.moves} ${Utils.wordEnding(_state.moves)}',
                          style: const TextStyle(fontSize: 16),
                        ),
                      ),
                      if (_state.rating != 3 ||
                          _state.isSingleFlipAdded ||
                          _state.isSolutionAdded ||
                          _state.isNewChapterOpened)
                        InfoCard(
                          Column(
                            children: [
                              if (_state.rating != 3)
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8.0),
                                  child: Text(
                                    'чтобы получить 3 звезды,\nпройди этот уровень за ${_state.bestResult} ${Utils.wordEnding(_state.bestResult)}',
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(fontSize: 16),
                                  ),
                                ),
                              if (_state.isNewChapterOpened)
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text(
                                        'открыта новая глава',
                                        style: TextStyle(
                                          fontSize: 16,
                                          color: context
                                              .read<AppTheme>()
                                              .accentColor,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              if (_state.isSolutionAdded)
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Icon(
                                        Icons.lightbulb_outline_rounded,
                                        size: 22,
                                        color: context
                                            .read<AppTheme>()
                                            .accentColor,
                                      ),
                                      const SizedBox(width: 5),
                                      Text(
                                        'получен просмотр решения',
                                        style: TextStyle(
                                            fontSize: 16,
                                            color: context
                                                .read<AppTheme>()
                                                .accentColor),
                                      ),
                                    ],
                                  ),
                                ),
                              if (_state.isSingleFlipAdded)
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Icon(
                                        Icons.flip,
                                        size: 22,
                                        color: context
                                            .read<AppTheme>()
                                            .accentColor,
                                      ),
                                      const SizedBox(width: 5),
                                      Text(
                                        'получен одиночный поворот',
                                        style: TextStyle(
                                            fontSize: 16,
                                            color: context
                                                .read<AppTheme>()
                                                .accentColor),
                                      ),
                                    ],
                                  ),
                                ),
                            ],
                          ),
                        ),
                      const SizedBox(height: 30),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          IconButton(
                            onPressed: () {
                              HapticFeedback.heavyImpact();
                              Navigator.pop(context, _state.levelId);
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
                              } else if (_state.isEndChapter) {
                                Navigator.popUntil(
                                  context,
                                  ModalRoute.withName(Routes.selectChapterMenu),
                                );
                              } else {
                                Navigator.pop(context, _state.nextLevelId);
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
          ),
        );
      },
    );
  }
}
