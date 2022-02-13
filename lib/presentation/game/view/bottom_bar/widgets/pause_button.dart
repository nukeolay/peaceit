import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import 'package:darkit/core/theme/app_theme.dart';
import 'package:darkit/presentation/game/view/bottom_bar/widgets/pause_dialog.dart';

class PauseButton extends StatelessWidget {
  const PauseButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        HapticFeedback.heavyImpact();
        showDialog(
          context: context,
          builder: (context) => PauseDialog(context),
        );
      },
      icon: Icon(
        Icons.pause_rounded,
        size: 30,
        color: context.read<AppTheme>().buttonTextColor,
      ),
    );
  }
}
