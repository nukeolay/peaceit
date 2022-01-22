import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:makeitdark/core/models/app_theme.dart';
import 'package:makeitdark/core/models/game.dart';
import 'package:makeitdark/core/routes/routes.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Game game = Provider.of<Game>(context, listen: false);

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
                const Spacer(),
                HomeScreenButton(
                  text: '[make it dark]',
                  function: () {
                    HapticFeedback.heavyImpact();
                    int lastLevelIndex = game.userData.completedLevels.length;
                    game.setLevelById(game.levels[lastLevelIndex].id);
                    Navigator.of(context).pushReplacementNamed(Routes.game);
                  },
                ),
                const SizedBox(height: 20),
                HomeScreenButton(
                  text: '[выбор уровня]',
                  function: () {
                    HapticFeedback.heavyImpact();
                    Navigator.of(context).pushNamed(Routes.select_level_menu);
                  },
                ),
                const SizedBox(height: 20),
                HomeScreenButton(
                  text: '[как играть]',
                  function: () {
                    // HapticFeedback.heavyImpact();
                    // Navigator.of(context).pushNamed(Routes.select_level_menu);
                  },
                ),
                const Spacer(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class HomeScreenButton extends StatelessWidget {
  const HomeScreenButton({
    required this.text,
    required this.function,
    Key? key,
  }) : super(key: key);

  final String text;
  final Function function;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      child: Text(
        text,
        style:
            TextStyle(color: context.read<AppTheme>().background, fontSize: 30),
      ),
      onPressed: () => {function()},
      style: ButtonStyle(
        overlayColor:
            MaterialStateProperty.all(context.read<AppTheme>().accentColor),
        backgroundColor: MaterialStateProperty.all(
          context.read<AppTheme>().cardBack,
        ),
      ),
    );
  }
}
