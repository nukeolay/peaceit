import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import 'package:darkit/core/theme/app_theme.dart';

class RestartButton extends StatelessWidget {
  const RestartButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        HapticFeedback.heavyImpact();
        // _game.restartLevel();
      },
      icon: Icon(
        Icons.replay_rounded,
        size: 30,
        color: context.read<AppTheme>().buttonTextColor,
      ),
    );
  }
}
