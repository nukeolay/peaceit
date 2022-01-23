import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import 'package:makeitdark/core/models/app_theme.dart';
import 'package:makeitdark/core/models/game.dart';
import 'package:makeitdark/core/routes/routes.dart';
import 'package:makeitdark/core/widgets/custom_alert_dialog.dart';

class BottomButtons extends StatefulWidget {
  const BottomButtons({Key? key}) : super(key: key);

  @override
  State<BottomButtons> createState() => _BottomButtonsState();
}

class _BottomButtonsState extends State<BottomButtons> {
  late Game _game;

  @override
  void didChangeDependencies() {
    _game = Provider.of<Game>(context);
    super.didChangeDependencies();
  }

  void _showPauseDialog() {
    double width = MediaQuery.of(context).size.width;
    showDialog(
      context: context,
      builder: (context) => CustomAlertDialog(
height: width / 2,
        width: width / 1.1,
        text: 'ПАУЗА',
        leftButtontext: 'Выйти',
        leftButtonFunction: () {
          HapticFeedback.heavyImpact();
          Navigator.of(context).pushReplacementNamed(Routes.home);
        },
        rightButtontext: 'Продолжить',
        rightButtonFunction: () {
          HapticFeedback.heavyImpact();
          Navigator.of(context).pop();
        },
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
          onPressed: _game.singleFlips > 0
              ? () {
                  HapticFeedback.heavyImpact();
                  _game.useSingeFlip();
                }
              : null,
          icon: _game.isSingleFlipOn
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
                  color: _game.singleFlips == 0
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
            _game.restartLevel();
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
