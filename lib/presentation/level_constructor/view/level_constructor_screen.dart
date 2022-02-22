import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import 'package:darkit/presentation/level_constructor/view_model/view_model.dart';
import 'package:darkit/presentation/level_constructor/view/widgets/constructor_game_field_grid.dart';
import 'package:darkit/presentation/level_constructor/view/widgets/top_bar.dart';
import 'package:darkit/presentation/level_constructor/view/widgets/created_level.dart';

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
            onPressed: () {
              HapticFeedback.heavyImpact();
              _viewModel.reset();
            },
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
                    TopBar(levelId: _levelId, state: _state),
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CreatedLevel(state: _state),
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
