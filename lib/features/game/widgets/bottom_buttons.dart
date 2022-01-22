import 'dart:ui';

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
    double width = MediaQuery.of(context).size.width;
    showDialog(
      context: context,
      builder: (ctx) => Align(
        alignment: Alignment.center,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(8.0),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
            child: Container(
              height: width / 3,
              width: width / 1.5,
              decoration: BoxDecoration(
                color: context.read<AppTheme>().cardBack.withOpacity(0.05),
                boxShadow: [
                  BoxShadow(
                    color: context.read<AppTheme>().cardBack.withOpacity(0.05),
                    blurRadius: 6.0,
                  ),
                ],
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      'ПАУЗА',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 20,
                        color: context.read<AppTheme>().buttonTextColor,
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: TextButton(
                          onPressed: () {
                            HapticFeedback.heavyImpact();
                            Navigator.of(context)
                                .pushReplacementNamed(Routes.home);
                          },
                          child: Text(
                            'Выйти',
                            style: TextStyle(
                              fontSize: 16,
                              color: context.read<AppTheme>().buttonTextColor,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: TextButton(
                          onPressed: () {
                            HapticFeedback.heavyImpact();
                            Navigator.of(ctx).pop();
                          },
                          child: Text(
                            'Продолжить',
                            style: TextStyle(
                              fontSize: 16,
                              color: context.read<AppTheme>().buttonTextColor,
                            ),
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
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
