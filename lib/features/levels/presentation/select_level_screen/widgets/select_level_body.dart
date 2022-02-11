import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:darkit/features/levels/presentation/select_level_screen/view_model/select_chapter_view_model.dart';
import 'package:darkit/features/levels/presentation/select_level_screen/widgets/levels_grid.dart';
import 'package:darkit/features/levels/presentation/select_level_screen/widgets/select_level_appbar.dart';

class SelectLevelBody extends StatelessWidget {
  const SelectLevelBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<SelectLevelViewModel>(
      create: (_) => SelectLevelViewModel(),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: ListView(
            physics: const BouncingScrollPhysics(),
            children: const [
              SelectLevelAppbar(),
              LevelsGrid(),
            ],
          ),
        ),
      ),
    );
  }
}
