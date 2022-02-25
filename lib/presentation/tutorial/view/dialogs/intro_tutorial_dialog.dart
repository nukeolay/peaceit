import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:darkit/core/routes/routes.dart';
import 'package:darkit/core/widgets/custom_alert_dialog.dart';

class IntroTutorialDialog extends StatelessWidget {
  final BuildContext contextWithProvider;
  const IntroTutorialDialog(this.contextWithProvider, {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double _width = MediaQuery.of(context).size.width;
    return CustomAlertDialog(
      centerMainText: false,
      height: _width / 1.3,
      width: _width / 1.1,
      text:
          'Цель игры - сделать все клетки темными за минимальное количество ходов.\n\nПопробуй понажимать на клетки, чтобы понять как это работает.',
      leftButtontext: 'Пропустить обучение',
      leftButtonFunction: () {
        HapticFeedback.heavyImpact();
        Navigator.of(context).pop();
        Navigator.of(context).pushReplacementNamed(Routes.selectChapterMenu);
      },
      rightButtontext: 'OK',
      rightButtonFunction: () {
        HapticFeedback.heavyImpact();
        Navigator.of(context).pop();
      },
    );
  }
}
