import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:peaceit/presentation/select_level/view_model/view_model.dart';
import 'package:peaceit/presentation/select_level/view/widgets/levels_grid.dart';
import 'package:peaceit/presentation/select_level/view/widgets/select_level_appbar.dart';
import 'package:peaceit/core/constants/default_game_settings.dart';

class SelectLevelSreen extends StatelessWidget {
  const SelectLevelSreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration.zero).then((_) {
      precacheImage(
          const AssetImage(DefaultGameSettings.backGroundImage), context);
    });
    String _chapterId = ModalRoute.of(context)!.settings.arguments as String;

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
        child: ChangeNotifierProvider<SelectLevelViewModel>(
          create: (_) => SelectLevelViewModel(_chapterId),
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: ListView(
                shrinkWrap: true,
                physics: const BouncingScrollPhysics(),
                children: const [
                  SelectLevelAppbar(),
                  LevelsGrid(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
