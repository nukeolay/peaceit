import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:darkit/core/widgets/custom_alert_dialog.dart';

class SolutionTutorialDialog extends StatelessWidget {
  final BuildContext contextWithProvider;
  const SolutionTutorialDialog(this.contextWithProvider, {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomAlertDialog(
      text: 'Воспользуйся подсказкой, посмотри решение - нажми на мигающую иконку.',
      icon: Icons.lightbulb_outline_rounded,
      rightButtontext: 'OK',
      rightButtonFunction: () {
        HapticFeedback.heavyImpact();
        Navigator.of(context).pop();
      },
    );
  }
}
