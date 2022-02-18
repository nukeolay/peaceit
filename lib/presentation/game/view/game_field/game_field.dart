import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:darkit/core/routes/routes.dart';
import 'package:darkit/presentation/game/view/game_field/widgets/cell_widget.dart';
import 'package:darkit/presentation/game/view/game_field/widgets/disable_multitouch.dart';
import 'package:darkit/presentation/game/view_model/view_model.dart';
import 'package:darkit/presentation/game/view_model/view_model_state.dart';

class GameField extends StatefulWidget {
  const GameField({
    Key? key,
  }) : super(key: key);

  @override
  State<GameField> createState() => _GameFieldState();
}

class _GameFieldState extends State<GameField> {
  late GameViewModel _viewModel; // = context.watch<GameViewModel>();
  late GameViewModelState _state; // = _viewModel.state;
  late final double width; // = MediaQuery.of(context).size.width;
  late final double cellWidth; // = width / _state.fieldLength - 10;
  bool _isInit = true;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    _viewModel = context.watch<GameViewModel>();
    _state = _viewModel.state;
    if (_isInit) {
      width = MediaQuery.of(context).size.width;
      cellWidth = width / _state.fieldLength - 10;
      _isInit = false;
    }

    WidgetsBinding.instance?.addPostFrameCallback((_) {
      if (true) {
        if (_state.isWin) {
          Navigator.of(context).pushNamed(Routes.levelCompleted,
              arguments:
                  _state.levelId); // TODO передавать количество ходов чтобы считать рейтинг
          // .whenComplete(_viewModel.update);
        }
      }
    });
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return DisableMultitouchWidget(
      child: GridView.builder(
        physics: const BouncingScrollPhysics(),
        itemCount: _state.cells.length,
        shrinkWrap: true,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: _state.fieldLength,
          crossAxisSpacing: 0,
          mainAxisSpacing: 0,
        ),
        padding: const EdgeInsets.all(0.0),
        itemBuilder: (context, index) => Center(
          child: SizedBox(
              width: cellWidth, height: cellWidth, child: CellWidget(index)),
        ),
      ),
    );
  }
}
