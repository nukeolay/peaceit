import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:easy_localization/easy_localization.dart';

import 'package:peaceit/core/routes/routes.dart';
import 'package:peaceit/core/widgets/custom_alert_dialog.dart';

class PauseDialog extends StatelessWidget {
  const PauseDialog(BuildContext context, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomAlertDialog(
      text: 'pause'.tr(),
      leftButtontext: 'button_exit'.tr(),
      leftButtonFunction: () {
        HapticFeedback.heavyImpact();
        Navigator.popUntil(
            context, ModalRoute.withName(Routes.selectLevelMenu));
      },
      rightButtontext: 'button_continue'.tr(),
      rightButtonFunction: () {
        HapticFeedback.heavyImpact();
        Navigator.of(context).pop();
      },
    );
  }
}
