import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:darkit/core/utils/utils.dart';
import 'package:darkit/core/constants/default_game_settings.dart';
import 'package:darkit/core/widgets/rating_row.dart';
import 'package:darkit/core/widgets/info_card.dart';

class TutorialLevelCompletedScreen extends StatelessWidget {
  const TutorialLevelCompletedScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration.zero).then((_) {
      precacheImage(
          const AssetImage(DefaultGameSettings.backGroundImage), context);
    });
    final _arguments =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    final _levelId = _arguments['levelId'] as String;
    final _nextLevelId = _arguments['nextLevelId'] as String?;
    final _moves = _arguments['moves'] as String;
    final _rating = _arguments['rating'] as int;
    final _bestResult = _arguments['bestResult'] as int;

    return WillPopScope(
      onWillPop: () {
        return Future.value(false);
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
                  RatingRow(rating: _rating),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'уровень пройден за $_moves ${Utils.wordEnding(int.parse(_moves))}',
                      style: const TextStyle(fontSize: 16),
                    ),
                  ),
                  InfoCard(
                    Column(
                      children: [
                        if (_rating != 3)
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 8.0),
                            child: Text(
                              'чтобы получить 3 звезды,\nпройди этот уровень за ${_bestResult} ${Utils.wordEnding(_bestResult)}',
                              textAlign: TextAlign.center,
                              style: const TextStyle(fontSize: 16),
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
                          Navigator.pop(context, _levelId);
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
                          Navigator.pop(context, _nextLevelId);
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
  }
}
