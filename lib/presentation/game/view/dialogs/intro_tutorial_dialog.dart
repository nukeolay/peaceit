import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:darkit/core/widgets/custom_alert_dialog.dart';

class IntroTutorialDialog extends StatelessWidget {
  final BuildContext contextWithProvider;
  const IntroTutorialDialog(this.contextWithProvider, {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomAlertDialog(
      centerMainText: false,
      text:
          'Цель игры - сделать все клетки "мирными" за минимальное количество ходов.\n\nПопробуй понажимать на клетки, чтобы понять как это работает.',
      rightButtontext: 'OK',
      rightButtonFunction: () {
        HapticFeedback.heavyImpact();
        Navigator.of(context).pop();
      },
    );
  }
}
