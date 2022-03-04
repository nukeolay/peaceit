import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:easy_localization/easy_localization.dart';

import 'package:darkit/core/widgets/custom_alert_dialog.dart';
import 'package:darkit/presentation/game/view_model/view_model.dart';

class SolutionDialog extends StatelessWidget {
  final BuildContext contextWithProvider;
  const SolutionDialog(this.contextWithProvider, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _viewModel = contextWithProvider.read<GameViewModel>();
    return CustomAlertDialog(
      text: 'tutorial_dialog_solution'.tr(),
      leftButtontext: 'button_solve'.tr(),
      leftButtonFunction: () async {
        HapticFeedback.heavyImpact();
        Navigator.of(context).pop();
        _viewModel.useSolution();
      },
      rightButtontext: 'button_cancel'.tr(),
      rightButtonFunction: () {
        HapticFeedback.heavyImpact();
        Navigator.of(context).pop();
      },
    );
  }
}
