import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:easy_localization/easy_localization.dart';

import 'package:darkit/core/widgets/custom_alert_dialog.dart';

class IntroTutorialDialog extends StatelessWidget {
  final BuildContext contextWithProvider;
  const IntroTutorialDialog(this.contextWithProvider, {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomAlertDialog(
      centerMainText: false,
      text: 'tutorial_info'.tr(),
      rightButtontext: 'button_ok'.tr(),
      rightButtonFunction: () {
        HapticFeedback.heavyImpact();
        Navigator.of(context).pop();
      },
    );
  }
}
