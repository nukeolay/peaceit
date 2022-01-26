import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import 'package:makeitdark/core/models/app_theme.dart';
import 'package:makeitdark/core/models/game.dart';
import 'package:makeitdark/core/routes/routes.dart';
import 'package:makeitdark/core/widgets/custom_text_button.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Game game = Provider.of<Game>(context, listen: false);
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/bg.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 30.0),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(30.0),
                    width: width,
                    child: FittedBox(
                      child: Text(
                        '[make it dark]',
                        style: TextStyle(
                          color: context
                              .read<AppTheme>()
                              .buttonTextColor
                              .withOpacity(0.5),
                        ),
                      ),
                    ),
                  ),
                ),
                // CustomTextButton(
                //   text: 'ИГРАТЬ',
                //   function: () {
                //     HapticFeedback.heavyImpact();
                //     int lastLevelIndex = game.userData.completedLevels.length;
                //     game.setLevelById(game.levels[lastLevelIndex].id);
                //     Navigator.of(context).pushReplacementNamed(Routes.game);
                //   },
                // ),
                const SizedBox(height: 50),
                CustomTextButton(
                  text: 'Играть',
                  function: () {
                    HapticFeedback.heavyImpact();
                    Navigator.of(context).pushNamed(Routes.selectLevelMenu);
                  },
                ),
                const SizedBox(height: 50),
                CustomTextButton(
                  text: 'Правила',
                  function: () {
                    HapticFeedback.heavyImpact();
                    Navigator.of(context).pushNamed(Routes.howToPlay);
                  },
                ),
                // const SizedBox(height: 50),
                // HomeScreenButton(
                //   text: 'РЕДАКТОР',
                //   function: () {
                //     HapticFeedback.heavyImpact();
                //     game.setLevelById('new');
                //     Navigator.of(context).pushNamed(Routes.levelConstructor);
                //   },
                // ),
                const Spacer(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
