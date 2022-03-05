import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:easy_localization/easy_localization.dart';

import 'package:peaceit/core/widgets/custom_alert_dialog.dart';

class SolutionTutorialDialog extends StatelessWidget {
  final BuildContext contextWithProvider;
  const SolutionTutorialDialog(this.contextWithProvider, {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomAlertDialog(
      text: 'tutorial_solution'.tr(),
      icon: Icons.lightbulb_outline_rounded,
      rightButtontext: 'button_ok'.tr(),
      rightButtonFunction: () {
        HapticFeedback.heavyImpact();
        Navigator.of(context).pop();
      },
    );
  }
}
