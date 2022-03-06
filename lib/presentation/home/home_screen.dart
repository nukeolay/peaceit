import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:peaceit/presentation/home/widgets/dove.dart';
import 'package:provider/provider.dart';
import 'package:easy_localization/easy_localization.dart';

import 'package:peaceit/core/theme/app_theme.dart';
import 'package:peaceit/core/routes/routes.dart';
import 'package:peaceit/core/constants/default_game_settings.dart';
import 'package:peaceit/presentation/home/widgets/editor_menu.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration.zero).then((_) {
      precacheImage(
          const AssetImage(DefaultGameSettings.backGroundImage), context);
    });

    return Scaffold(
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
          child: GestureDetector(
            behavior: HitTestBehavior.translucent,
            onTap: () {
              HapticFeedback.heavyImpact();
              Navigator.of(context).pushNamed(Routes.selectChapterMenu);
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 30.0),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  const DoveAnimated(),
                  Text(
                    'title'.tr(),
                    style: TextStyle(
                      color: context
                          .read<AppTheme>()
                          .buttonTextColor
                          .withOpacity(0.7),
                      fontSize: 50,
                    ),
                  ),
                  if (DefaultGameSettings.isEditorOn) const EditorMenu(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
