import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:darkit/features/levels/presentation/select_level_screen/view_model/view_model.dart';
import 'package:darkit/features/levels/presentation/select_level_screen/widgets/levels_grid.dart';
import 'package:darkit/features/levels/presentation/select_level_screen/widgets/select_level_appbar.dart';

class SelectLevelView extends StatelessWidget {
  const SelectLevelView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String _chapterId = ModalRoute.of(context)!.settings.arguments as String;

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
        child: ChangeNotifierProvider<SelectLevelViewModel>(
          create: (_) => SelectLevelViewModel(_chapterId),
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
        ),
      ),
    );
  }
}
