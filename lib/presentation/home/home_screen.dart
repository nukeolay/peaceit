import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shimmer/shimmer.dart';
import 'package:easy_localization/easy_localization.dart';

import 'package:darkit/core/theme/app_theme.dart';
import 'package:darkit/core/routes/routes.dart';
import 'package:darkit/core/constants/default_game_settings.dart';
import 'package:darkit/presentation/home/widgets/editor_menu.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration.zero).then((_) {
      precacheImage(
          const AssetImage(DefaultGameSettings.backGroundImage), context);
    });
    double width = MediaQuery.of(context).size.width;

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
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 30.0),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // const SizedBox(height: 50),
                GestureDetector(
                  onTap: () {
                    HapticFeedback.heavyImpact();
                    Navigator.of(context).pushNamed(Routes.selectChapterMenu);
                  },
                  child: Container(
                    padding: const EdgeInsets.all(20.0),
                    width: width / 1.2,
                    height: width / 1.2,
                    child: Stack(
                      fit: StackFit.expand,
                      children: [
                        SvgPicture.asset('assets/dove.svg'),
                        Shimmer.fromColors(
                          baseColor: Colors.transparent,
                          highlightColor: context
                              .read<AppTheme>()
                              .cardBack
                              .withOpacity(0.3),
                          child: SvgPicture.asset('assets/dove.svg'),
                        ),
                      ],
                    ),
                  ),
                ),
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
    );
  }
}
