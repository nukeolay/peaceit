import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import 'package:darkit/core/theme/app_theme.dart';
import 'package:darkit/core/routes/routes.dart';
import 'package:darkit/core/widgets/custom_text_button.dart';

class TutorialScreen extends StatelessWidget {
  const TutorialScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration.zero).then((_) {
      precacheImage(const AssetImage('assets/bg.png'), context);
    });
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/bg.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 30.0),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(30.0),
                    width: width,
                    child: FittedBox(
                      child: Text(
                        'tutorial',
                        style: TextStyle(
                          color: context
                              .read<AppTheme>()
                              .buttonTextColor
                              .withOpacity(0.5),
                        ),
                      ),
                    ),
                  ),
                ),
                CustomTextButton(
                  text: 'К выбору главы',
                  function: () {
                    HapticFeedback.heavyImpact();
                    Navigator.of(context)
                        .pushReplacementNamed(Routes.selectChapterMenu);
                  },
                ),
                const Spacer(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
