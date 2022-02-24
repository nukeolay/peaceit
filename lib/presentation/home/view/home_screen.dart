import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import 'package:darkit/core/theme/app_theme.dart';
import 'package:darkit/core/routes/routes.dart';
import 'package:darkit/core/widgets/custom_text_button.dart';
import 'package:darkit/core/constants/default_game_settings.dart';
import 'package:darkit/presentation/home/view/widgets/editor_menu.dart';
import 'package:darkit/presentation/home/view_model/view_model.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);
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
        child: ChangeNotifierProvider<HomeViewModel>(
            create: (_) => HomeViewModel(),
            builder: (context, _) {
              final _viewModel = context.read<HomeViewModel>();
              return SafeArea(
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
                              '[dark it]',
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
                      const SizedBox(height: 50),
                      CustomTextButton(
                        text: 'Играть',
                        function: () {
                          HapticFeedback.heavyImpact();
                          _viewModel.checkIsFirstStart()
                              ? Navigator.of(context).pushNamed(Routes.tutorial,
                                  arguments: 'tut6x6n1')
                              : Navigator.of(context)
                                  .pushNamed(Routes.selectChapterMenu);
                        },
                      ),
                      if (DefaultGameSettings.isEditorOn) const EditorMenu(),
                      const Spacer(),
                    ],
                  ),
                ),
              );
            }),
      ),
    );
  }
}
