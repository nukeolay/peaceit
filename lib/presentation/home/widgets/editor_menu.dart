import 'package:darkit/core/routes/routes.dart';
import 'package:darkit/core/widgets/custom_text_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class EditorMenu extends StatelessWidget {
  const EditorMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 10),
        CustomTextButton(
          text: 'Editor 3x3',
          function: () {
            HapticFeedback.heavyImpact();
            Navigator.of(context)
                .pushNamed(Routes.levelConstructor, arguments: 'new 3x3');
          },
        ),
        const SizedBox(height: 10),
        CustomTextButton(
          text: 'Editor 4x4',
          function: () {
            HapticFeedback.heavyImpact();
            Navigator.of(context)
                .pushNamed(Routes.levelConstructor, arguments: 'new 4x4');
          },
        ),
        const SizedBox(height: 10),
        CustomTextButton(
          text: 'Editor 5x5',
          function: () {
            HapticFeedback.heavyImpact();
            Navigator.of(context)
                .pushNamed(Routes.levelConstructor, arguments: 'new 5x5');
          },
        ),
        const SizedBox(height: 10),
        CustomTextButton(
          text: 'Editor 6x6',
          function: () {
            HapticFeedback.heavyImpact();
            Navigator.of(context)
                .pushNamed(Routes.levelConstructor, arguments: 'new 6x6');
          },
        ),
      ],
    );
  }
}
