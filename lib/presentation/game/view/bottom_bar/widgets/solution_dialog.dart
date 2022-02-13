import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:darkit/core/widgets/custom_alert_dialog.dart';

class SolutionDialog extends StatelessWidget {
  const SolutionDialog(BuildContext context, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return CustomAlertDialog(
      height: width / 2,
      width: width / 1.1,
      text: 'Показать решение?',
      leftButtontext: 'Показать',
      leftButtonFunction: () async {
        HapticFeedback.heavyImpact();
        Navigator.of(context).pop();
        // _game.useSolution();
        // await _game.solutionsNumberDecrement();
      },
      rightButtontext: 'Отмена',
      rightButtonFunction: () {
        HapticFeedback.heavyImpact();
        Navigator.of(context).pop();
      },
    );
  }
}
