import 'package:darkit/core/models/game.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import 'package:darkit/core/models/app_theme.dart';
import 'package:darkit/core/routes/routes.dart';
import 'package:darkit/core/widgets/custom_text_button.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
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
                        '[dark it]',
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
                const SizedBox(height: 50),
                CustomTextButton(
                  text: 'Играть',
                  function: () {
                    HapticFeedback.heavyImpact();
                    context.read<Game>().isFirstStart
                        ? Navigator.of(context).pushNamed(Routes.selectChapterMenu) // TODO когда сделаю tutorial поменять тут на Routes.tutorial
                        : Navigator.of(context)
                            .pushNamed(Routes.selectChapterMenu);
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
                // CustomTextButton(
                //   text: 'Редактор 3x3',
                //   function: () {
                //     HapticFeedback.heavyImpact();
                //     Navigator.of(context).pushNamed(Routes.levelConstructor,
                //         arguments: 'new 3x3');
                //   },
                // ),
                // const SizedBox(height: 50),
                // CustomTextButton(
                //   text: 'Редактор 4x4',
                //   function: () {
                //     HapticFeedback.heavyImpact();
                //     Navigator.of(context).pushNamed(Routes.levelConstructor,
                //         arguments: 'new 4x4');
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