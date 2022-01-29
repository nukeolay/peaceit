import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import 'package:darkit/core/models/app_theme.dart';
import 'package:darkit/core/models/game.dart';
import 'package:darkit/core/models/game_field.dart';
import 'package:darkit/core/routes/routes.dart';
import 'package:darkit/core/utils/utils.dart';

class LevelCompletedScreen extends StatefulWidget {
  const LevelCompletedScreen({Key? key}) : super(key: key);

  @override
  State<LevelCompletedScreen> createState() => _LevelCompletedScreenState();
}

class _LevelCompletedScreenState extends State<LevelCompletedScreen> {
  late String _levelId;
  bool _isInit = true;

  @override
  void didChangeDependencies() {
    if (_isInit) {
      _isInit = false;
      _levelId = ModalRoute.of(context)!.settings.arguments as String;
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    Game game = context.read<Game>();
    GameField gameField = game.gameField;
    int movesNumber = gameField.movesNumber;
    int rating = game.rating();
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
                RatingRow(rating: rating),
                // if (rating == 3)
                //   const Padding(
                //     padding: EdgeInsets.all(8.0),
                //     child: Text(
                //       '+1 одиночный поворот',
                //       style: TextStyle(fontSize: 22),
                //     ),
                //   ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'уровень пройден за $movesNumber ${Utils.wordEnding(movesNumber)}',
                    style: const TextStyle(fontSize: 16),
                  ),
                ),
                if (rating != 3)
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
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Text(
                            'чтобы получить 3 звезды,\nпройди этот уровень за ${game.levelById(_levelId).bestResult} ${Utils.wordEnding(game.levelById(_levelId).bestResult)}',
                            textAlign: TextAlign.center,
                            style: const TextStyle(fontSize: 16),
                          ),
                        ),
                      ),
                    ),
                  ),
                const SizedBox(height: 30),
                // TODO проверять, если закончено более 70% в глаые, писать, что открыта новая глава
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      onPressed: () {
                        HapticFeedback.heavyImpact();
                        Navigator.of(context).pushReplacementNamed(Routes.game,
                            arguments: _levelId);
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
                        if (game.isGameFinished) {
                          Navigator.of(context)
                              .pushReplacementNamed(Routes.gameFinished);
                        } else {
                          try {
                            String _nextLevelId =
                                game.nextLevelIdByPreviousId(_levelId);
                            Navigator.of(context).pushReplacementNamed(
                                Routes.game,
                                arguments: _nextLevelId);
                          } catch (error) {
                            Navigator.of(context)
                                .pushReplacementNamed(Routes.selectChapterMenu);
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
