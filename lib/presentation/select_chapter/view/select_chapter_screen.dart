import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:peaceit/presentation/select_chapter/view_model/view_model.dart';
import 'package:peaceit/presentation/select_chapter/view/widgets/chapters_grid.dart';
import 'package:peaceit/presentation/select_chapter/view/widgets/select_chapter_appbar.dart';
import 'package:peaceit/core/constants/default_game_settings.dart';

class SelectChapterScreen extends StatelessWidget {
  const SelectChapterScreen({Key? key}) : super(key: key);

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
        child: ChangeNotifierProvider<SelectChapterViewModel>(
          create: (_) => SelectChapterViewModel(),
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: ListView(
                physics: const BouncingScrollPhysics(),
                children: const [
                  SelectChapterAppbar(),
                  ChaptersGrid(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
