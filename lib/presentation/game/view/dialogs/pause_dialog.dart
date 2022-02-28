import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:darkit/core/routes/routes.dart';
import 'package:darkit/core/widgets/custom_alert_dialog.dart';

class PauseDialog extends StatelessWidget {
  const PauseDialog(BuildContext context, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomAlertDialog(
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
    );
  }
}
