import 'package:flutter/material.dart';
import 'package:peaceit/core/widgets/template_screen.dart';
import 'package:provider/provider.dart';

import 'package:peaceit/presentation/select_chapter/view_model/view_model.dart';
import 'package:peaceit/presentation/select_chapter/view/widgets/chapters_grid.dart';
import 'package:peaceit/presentation/select_chapter/view/widgets/select_chapter_appbar.dart';

class SelectChapterScreen extends StatelessWidget {
  const SelectChapterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TemplateScreen(
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
    );
  }
}
