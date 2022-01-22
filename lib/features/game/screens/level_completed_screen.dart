import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:makeitdark/core/models/app_theme.dart';
import 'package:makeitdark/core/models/game.dart';
import 'package:makeitdark/core/models/game_field.dart';
import 'package:makeitdark/core/routes/routes.dart';

import 'package:makeitdark/utils/utils.dart';
import 'package:provider/provider.dart';

class LevelCompletedScreen extends StatelessWidget {
  const LevelCompletedScreen({Key? key}) : super(key: key);
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
                const SizedBox(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      onPressed: () {
                        HapticFeedback.heavyImpact();
                        game.restart();
                        Navigator.of(context).pushReplacementNamed(Routes.game);
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
                        game.nextLevel();
                        Navigator.of(context).pushReplacementNamed(Routes.game);
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
          color: context.read<AppTheme>().buttonTextColor,
          size: 36,
        ),
        Icon(
          rating >= 2
              ? Icons.star_rounded
              : Icons.star_outline_rounded,
          color: context.read<AppTheme>().buttonTextColor,
          size: 36,
        ),
        Icon(
          rating == 3
              ? Icons.star_rounded
              : Icons.star_outline_rounded,
          color: context.read<AppTheme>().buttonTextColor,
          size: 36,
        ),
      ],
    );
  }
}
