import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:darkit/presentation/game/view/top_bar/widgets/top_info_element.dart';
import 'package:darkit/presentation/level_constructor/view/constructor_field/constructor_game_field_grid.dart';
import 'package:darkit/presentation/level_constructor/view/widgets/result_bar.dart';
import 'package:darkit/presentation/level_constructor/view_model/view_model.dart';

class LevelConstructorScreen extends StatelessWidget {
  const LevelConstructorScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration.zero).then((_) {
      precacheImage(const AssetImage('assets/bg.png'), context);
    });
    String _levelId = ModalRoute.of(context)!.settings.arguments as String;

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
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 8.0,
              vertical: 10,
            ),
            child: ChangeNotifierProvider<ConstructorViewModel>(
              create: (_) => ConstructorViewModel(_levelId),
              builder: (context, _) {
                final _viewModel = context.watch<ConstructorViewModel>();
                final _state = _viewModel.state;
                return Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TopInfoElement(
                          topData: _levelId,
                          bottomData: 'уровень',
                        ),
                        TopInfoElement(
                          topData: _state.moves,
                          bottomData: 'количество\nходов',
                        ),
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        ConstructorGameField(),
                      ],
                    ),
                    ResultBar(
                      _state.cells,
                      _state.inputCells,
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
