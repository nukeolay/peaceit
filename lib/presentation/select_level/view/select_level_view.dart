import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:darkit/presentation/select_level/view_model/view_model.dart';
import 'package:darkit/presentation/select_level/widgets/levels_grid.dart';
import 'package:darkit/presentation/select_level/widgets/select_level_appbar.dart';

class SelectLevelView extends StatefulWidget {
  const SelectLevelView({Key? key}) : super(key: key);

  @override
  State<SelectLevelView> createState() => _SelectLevelViewState();
}

class _SelectLevelViewState extends State<SelectLevelView> {
  @override
  void initState() {
    Future.delayed(Duration.zero).then((_) {
      precacheImage(const AssetImage('assets/bg.png'), context);
    });
    super.initState();
  }

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
