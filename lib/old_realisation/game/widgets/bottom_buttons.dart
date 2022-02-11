import 'dart:ui';

import 'package:darkit/core/app_theme.dart';
import 'package:darkit/old_realisation/models/game.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import 'package:darkit/core/routes/routes.dart';
import 'package:darkit/core/widgets/custom_alert_dialog.dart';

class BottomButtons extends StatefulWidget {
  const BottomButtons({Key? key}) : super(key: key);

  @override
  State<BottomButtons> createState() => _BottomButtonsState();
}

class _BottomButtonsState extends State<BottomButtons> {
  late Game _game;
  bool _isInit = true;

  @override
  void didChangeDependencies() {
    if (_isInit) {
      _isInit = false;
      _game = Provider.of<Game>(context);
    }
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
          Navigator.popUntil(
              context, ModalRoute.withName(Routes.selectLevelMenu));
        },
        rightButtontext: 'Продолжить',
        rightButtonFunction: () {
          HapticFeedback.heavyImpact();
          Navigator.of(context).pop();
        },
      ),
    );
  }

  void _showSolutionDialog() {
    double width = MediaQuery.of(context).size.width;
    showDialog(
      context: context,
      builder: (context) => CustomAlertDialog(
        height: width / 2,
        width: width / 1.1,
        text: 'Показать решение?',
        leftButtontext: 'Показать',
        leftButtonFunction: () async {
          HapticFeedback.heavyImpact();
          Navigator.of(context).pop();
          _game.useSolution();
          await _game.solutionsNumberDecrement();
        },
        rightButtontext: 'Отмена',
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
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: IconButton(
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
        ),
        ClipRRect(
          borderRadius: BorderRadius.circular(8.0),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
            child: Container(
              padding: const EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                color: context.read<AppTheme>().cardBack.withOpacity(0.1),
                boxShadow: [
                  BoxShadow(
                    color: context.read<AppTheme>().cardBack.withOpacity(0.05),
                    blurRadius: 6.0,
                  ),
                ],
              ),
              child: Row(
                children: [
                  Column(
                    children: [
                      Text(
                        '${_game.singleFlips}',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 20,
                          color: _game.canUseSingleFlips()
                              ? context.read<AppTheme>().buttonTextColor
                              : context
                                  .read<AppTheme>()
                                  .buttonTextColor
                                  .withOpacity(0.2),
                        ),
                      ),
                      IconButton(
                        tooltip: 'перевернуть одну ячейку',
                        onPressed: _game.canUseSingleFlips()
                            ? () {
                                HapticFeedback.heavyImpact();
                                _game.useSingleFlip();
                              }
                            : null,
                        icon: Icon(
                          Icons.flip,
                          size: 30,
                          color: _game.canUseSingleFlips()
                              ? _game.isSingleFlipOn
                                  ? context.read<AppTheme>().accentColor
                                  : context.read<AppTheme>().buttonTextColor
                              : context
                                  .read<AppTheme>()
                                  .buttonTextColor
                                  .withOpacity(0.2),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(width: 20),
                  Column(
                    children: [
                      Text(
                        '${_game.solutionsNumber}',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 20,
                          color: _game.canUseSolution()
                              ? context.read<AppTheme>().buttonTextColor
                              : context
                                  .read<AppTheme>()
                                  .buttonTextColor
                                  .withOpacity(0.2),
                        ),
                      ),
                      IconButton(
                        tooltip: 'показать решение',
                        onPressed: _game.canUseSolution()
                            ? () {
                                HapticFeedback.heavyImpact();
                                _showSolutionDialog();
                              }
                            : null,
                        icon: Icon(
                          Icons.lightbulb_outline_rounded,
                          size: 30,
                          color: _game.canUseSolution()
                              ? context.read<AppTheme>().buttonTextColor
                              : context
                                  .read<AppTheme>()
                                  .buttonTextColor
                                  .withOpacity(0.2),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: IconButton(
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
        ),
      ],
    );
  }
}
