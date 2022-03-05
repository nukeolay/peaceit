import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:easy_localization/easy_localization.dart';

import 'package:peaceit/core/constants/default_game_settings.dart';
import 'package:peaceit/core/theme/app_theme.dart';
import 'package:peaceit/core/routes/routes.dart';
import 'package:peaceit/core/widgets/custom_text_button.dart';

class GameFinishedScreen extends StatelessWidget {
  const GameFinishedScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration.zero).then((_) {
      precacheImage(
          const AssetImage(DefaultGameSettings.backGroundImage), context);
    });
    double width = MediaQuery.of(context).size.width;
    return WillPopScope(
      onWillPop: () {
        Navigator.popUntil(
            context, ModalRoute.withName(Routes.selectChapterMenu));
        return Future.value(true);
      },
      child: Scaffold(
        body: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage(DefaultGameSettings.backGroundImage),
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
                          'end_game'.tr(),
                          style: TextStyle(
                            color: context
                                .read<AppTheme>()
                                .buttonTextColor
                                .withOpacity(0.7),
                          ),
                        ),
                      ),
                    ),
                  ),
                  CustomTextButton(
                    text: 'button_finish'.tr(),
                    function: () {
                      HapticFeedback.heavyImpact();
                      Navigator.popUntil(context,
                          ModalRoute.withName(Routes.selectChapterMenu));
                    },
                  ),
                  const Spacer(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
