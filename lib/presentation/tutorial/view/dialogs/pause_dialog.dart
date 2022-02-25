import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:darkit/core/widgets/custom_alert_dialog.dart';

class PauseDialog extends StatelessWidget {
  const PauseDialog(BuildContext context, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return CustomAlertDialog(
      height: width / 2,
      width: width / 1.1,
      text: 'ПАУЗА',
      leftButtontext: 'Выйти',
      leftButtonFunction: () {
        HapticFeedback.heavyImpact();
        Navigator.of(context).pop();
        Navigator.of(context).pop();
      },
      rightButtontext: 'Продолжить',
      rightButtonFunction: () {
        HapticFeedback.heavyImpact();
        Navigator.of(context).pop();
      },
    );
  }
}
