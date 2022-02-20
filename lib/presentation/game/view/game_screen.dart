import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:darkit/presentation/game/view/bottom_bar/bottom_bar.dart';
import 'package:darkit/presentation/game/view/game_field/game_field.dart';
import 'package:darkit/presentation/game/view/top_bar/top_bar.dart';
import 'package:darkit/presentation/game/view_model/view_model.dart';
import 'package:darkit/presentation/game/view/bottom_bar/widgets/pause_dialog.dart';

class GameScreen extends StatelessWidget {
  const GameScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration.zero).then((_) {
      precacheImage(const AssetImage('assets/bg.png'), context);
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
              image: AssetImage('assets/bg.png'),
              fit: BoxFit.cover,
            ),
          ),
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 8.0,
                vertical: 10,
              ),
              child: ChangeNotifierProvider<GameViewModel>(
                create: (_) => GameViewModel(_levelId),
                child: Column(
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
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
