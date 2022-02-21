import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:darkit/presentation/game/view/top_bar/widgets/top_info_element.dart';
import 'package:darkit/presentation/level_constructor/view/constructor_field/constructor_game_field_grid.dart';
import 'package:darkit/presentation/level_constructor/view_model/view_model.dart';

class LevelConstructorScreen extends StatelessWidget {
  const LevelConstructorScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration.zero).then((_) {
      precacheImage(const AssetImage('assets/bg.png'), context);
    });
    String _levelId = ModalRoute.of(context)!.settings.arguments as String;

    return ChangeNotifierProvider<ConstructorViewModel>(
      create: (_) => ConstructorViewModel(_levelId),
      builder: (context, _) {
        final _viewModel = context.watch<ConstructorViewModel>();
        final _state = _viewModel.state;
        return Scaffold(
          floatingActionButton: FloatingActionButton(
            onPressed: _viewModel.reset,
            child: const Icon(Icons.refresh_rounded),
          ),
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
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
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
                    ),
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: const EdgeInsets.only(right: 8.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'x, y, isBlack',
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                ..._state.cells.map(
                                  (cell) => Text(
                                    '${cell.x}, ${cell.y}${!cell.isBlack ? ', ${!cell.isBlack}' : ''}',
                                    style: const TextStyle(fontSize: 12),
                                    textAlign: TextAlign.start,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: LayoutBuilder(
                              builder: (context, constraints) {
                                return Column(
                                  children: [
                                    SizedBox(
                                        height: constraints.maxHeight / 2,
                                        child: const ConstructorGameField()),
                                    SizedBox(
                                      height: constraints.maxHeight / 2,
                                      child: ListView(
                                        reverse: true,
                                        children: [
                                          ..._state.inputCells.map(
                                            (cell) => Text(
                                              '${cell.x}, ${cell.y}',
                                              style:
                                                  const TextStyle(fontSize: 20),
                                              textAlign: TextAlign.center,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
