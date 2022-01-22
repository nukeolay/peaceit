import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:makeitdark/core/models/app_theme.dart';
import 'package:makeitdark/core/models/game.dart';
import 'package:makeitdark/core/routes/routes.dart';
import 'package:provider/provider.dart';

class BottomButtons extends StatefulWidget {
  const BottomButtons({Key? key}) : super(key: key);

  @override
  State<BottomButtons> createState() => _BottomButtonsState();
}

class _BottomButtonsState extends State<BottomButtons> {
  late Game game;

  @override
  void didChangeDependencies() {
    game = Provider.of<Game>(context);
    super.didChangeDependencies();
  }

  void _showPauseDialog() {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: context.read<AppTheme>().background.withOpacity(0.6),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
        title: Text(
          'ПАУЗА',
          textAlign: TextAlign.center,
          style: TextStyle(color: context.read<AppTheme>().buttonTextColor),
        ),
        elevation: 0,
        actionsAlignment: MainAxisAlignment.spaceBetween,
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: TextButton(
              onPressed: () {
                HapticFeedback.heavyImpact();
                Navigator.of(context).pushReplacementNamed(Routes.home);
              },
              child: Text(
                'Выйти',
                style: TextStyle(
                  color: context.read<AppTheme>().buttonTextColor,
                ),
              ),
            ),
          ),
          TextButton(
            onPressed: () {
              HapticFeedback.heavyImpact();
              Navigator.of(ctx).pop();
            },
            child: Text(
              'Продолжить',
              style: TextStyle(
                color: context.read<AppTheme>().buttonTextColor,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        IconButton(
          onPressed: () {
            HapticFeedback.heavyImpact();
            _showPauseDialog();
          },
          icon: Icon(
            Icons.pause_rounded,
            size: 30,
            color: context.read<AppTheme>().buttonTextColor,
          ),
        ),
        IconButton(
          onPressed: game.singleFlips > 0
              ? () {
                  HapticFeedback.heavyImpact();
                  game.useSingeFlip();
                }
              : null,
          icon: game.isSingleFlipOn
              ? CircleAvatar(
                  child: Icon(
                    Icons.flip,
                    size: 30,
                    color: context.read<AppTheme>().cardFront,
                  ),
                )
              : Icon(
                  Icons.flip,
                  size: 30,
                  color: game.singleFlips == 0
                      ? context
                          .read<AppTheme>()
                          .buttonTextColor
                          .withOpacity(0.2)
                      : context.read<AppTheme>().buttonTextColor,
                ),
        ),
        IconButton(
          onPressed: () {
            HapticFeedback.heavyImpact();
            game.restart();
          },
          icon: Icon(
            Icons.replay_rounded,
            size: 30,
            color: context.read<AppTheme>().buttonTextColor,
          ),
        ),
      ],
    );
  }
}
