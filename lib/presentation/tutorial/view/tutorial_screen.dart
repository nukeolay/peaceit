import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:darkit/core/constants/default_game_settings.dart';
import 'package:darkit/presentation/tutorial/view/bottom_bar/bottom_bar.dart';
import 'package:darkit/presentation/tutorial/view/dialogs/pause_dialog.dart';
import 'package:darkit/presentation/tutorial/view/game_field/game_field.dart';
import 'package:darkit/presentation/tutorial/view/top_bar/top_bar.dart';
import 'package:darkit/presentation/tutorial/view_model/view_model.dart';

class TutorialScreen extends StatelessWidget {
  const TutorialScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration.zero).then((_) {
      precacheImage(
          const AssetImage(DefaultGameSettings.backGroundImage), context);
    });
    String _levelId = ModalRoute.of(context)!.settings.arguments as String;

    return WillPopScope(
      onWillPop: () {
        showDialog(
          context: context,
          builder: (context) => PauseDialog(context),
        );
        return Future.value(false);
      },
      child: Scaffold(
        body: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage(DefaultGameSettings.backGroundImage),
              fit: BoxFit.cover,
            ),
          ),
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 8.0,
                vertical: 10,
              ),
              child: ChangeNotifierProvider<TutorialViewModel>(
                create: (_) => TutorialViewModel(_levelId),
                builder: (context, _) {
                  return Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const TopBar(),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          GameField(),
                        ],
                      ),
                      const Spacer(),
                      const BottomBar(),
                    ],
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
