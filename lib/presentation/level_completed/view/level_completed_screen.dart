import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:easy_localization/easy_localization.dart';

import 'package:peaceit/core/constants/default_game_settings.dart';
import 'package:peaceit/core/routes/routes.dart';
import 'package:peaceit/core/theme/app_theme.dart';
import 'package:peaceit/presentation/level_completed/view/widgets/rating_row.dart';
import 'package:peaceit/presentation/level_completed/view/widgets/info_card.dart';
import 'package:peaceit/presentation/level_completed/view_model/view_model.dart';

class LevelCompletedScreen extends StatelessWidget {
  const LevelCompletedScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration.zero).then((_) {
      precacheImage(
          const AssetImage(DefaultGameSettings.backGroundImage), context);
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
                  image: AssetImage(DefaultGameSettings.backGroundImage),
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
                          'level_completed_in'.plural(_state.moves),
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
                                    'level_best_result'
                                        .plural(_state.bestResult),
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
                                        'new_chapter_opened'.tr(),
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
                                        'new_hint_solution'.tr(),
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
                                        'new_hint_single_flip'.tr(),
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
                              kIsWeb ? Icons.replay : Icons.replay_rounded,
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
