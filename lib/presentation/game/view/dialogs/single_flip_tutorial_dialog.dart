import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:darkit/core/widgets/custom_alert_dialog.dart';

class SingleFlipTutorialDialog extends StatelessWidget {
  const SingleFlipTutorialDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomAlertDialog(
      centerMainText: false,
      text:
          'Если у тебя не получается пройти уровень и не осталось подсказок для просмотра решения, ты можешь перевернуть отдельную ячейку.\n\nНажми на мигающую иконку, а затем на ячейку, которую хочешь перевернуть.\nПопробуй, это просто!',
      icon: Icons.flip,
      rightButtontext: 'OK',
      rightButtonFunction: () {
        HapticFeedback.heavyImpact();
        Navigator.of(context).pop();
      },
    );
  }
}
