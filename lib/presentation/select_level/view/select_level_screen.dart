import 'package:flutter/material.dart';
import 'package:peaceit/core/widgets/template_screen.dart';
import 'package:provider/provider.dart';

import 'package:peaceit/presentation/select_level/view_model/view_model.dart';
import 'package:peaceit/presentation/select_level/view/widgets/levels_grid.dart';
import 'package:peaceit/presentation/select_level/view/widgets/select_level_appbar.dart';

class SelectLevelSreen extends StatelessWidget {
  const SelectLevelSreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String _chapterId = ModalRoute.of(context)!.settings.arguments as String;
    return TemplateScreen(
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
    );
  }
}
