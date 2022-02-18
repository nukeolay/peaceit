import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:darkit/presentation/game/view/game_field/widgets/cell_widget.dart';
import 'package:darkit/presentation/game/view/game_field/widgets/disable_multitouch.dart';
import 'package:darkit/presentation/game/view_model/view_model.dart';
import 'package:darkit/presentation/game/view_model/view_model_state.dart';

class GameField extends StatelessWidget {
  const GameField({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final GameViewModel _viewModel = context.watch<GameViewModel>();
    final GameViewModelState _state = _viewModel.state;
    final double width = MediaQuery.of(context).size.width;
    final double cellWidth = width / _state.fieldLength - 10;

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
            width: cellWidth,
            height: cellWidth,
            child: CellWidget(index)
          ),
        ),
      ),
    );
  }
}
