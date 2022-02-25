import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:darkit/core/constants/default_game_settings.dart';
import 'package:darkit/core/routes/routes.dart';

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
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      'уровень пройден',
                      style: TextStyle(fontSize: 16),
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
