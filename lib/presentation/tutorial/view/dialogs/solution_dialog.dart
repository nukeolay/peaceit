import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import 'package:darkit/core/widgets/custom_alert_dialog.dart';
import 'package:darkit/presentation/tutorial/view_model/view_model.dart';

class SolutionDialog extends StatelessWidget {
  final BuildContext contextWithProvider;
  const SolutionDialog(this.contextWithProvider, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _viewModel = contextWithProvider.read<TutorialViewModel>();
    final double _width = MediaQuery.of(context).size.width;
    return CustomAlertDialog(
      height: _width / 2,
      width: _width / 1.1,
      text: 'Показать решение?',
      leftButtontext: 'Показать',
      leftButtonFunction: () async {
        HapticFeedback.heavyImpact();
        Navigator.of(context).pop();
        _viewModel.useSolution();
      },
      rightButtontext: 'Отмена',
      rightButtonFunction: () {
        HapticFeedback.heavyImpact();
        Navigator.of(context).pop();
      },
    );
  }
}