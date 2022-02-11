import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:darkit/features/levels/presentation/select_chapter_screen/view_models/select_chapter_view_model.dart';
import 'package:darkit/features/levels/presentation/select_chapter_screen/widgets/chapters_grid.dart';
import 'package:darkit/features/levels/presentation/select_chapter_screen/widgets/select_chapter_appbar.dart';
class SelectChapterBody extends StatelessWidget {
  const SelectChapterBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<SelectChapterViewModel>(
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
    );
  }
}
