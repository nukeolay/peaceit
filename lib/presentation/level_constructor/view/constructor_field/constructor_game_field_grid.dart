import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import 'package:darkit/presentation/game/view/game_field/widgets/disable_multitouch.dart';
import 'package:darkit/presentation/level_constructor/view_model/view_model.dart';
import 'package:darkit/presentation/level_constructor/view_model/view_model_state.dart';
import 'package:darkit/presentation/level_constructor/view/widgets/constructor_cell_widget.dart';

class ConstructorGameField extends StatelessWidget {
  const ConstructorGameField({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ConstructorViewModel _viewModel =
        context.watch<ConstructorViewModel>();
    final ConstructorViewModelState _state = _viewModel.state;
    final double _width = MediaQuery.of(context).size.width;
    final double _cellWidth = _width / _state.fieldLength * 0.92;

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
            width: _cellWidth,
            height: _cellWidth,
            child: GestureDetector(
              onTap: () {
                HapticFeedback.heavyImpact();
                _viewModel.flipCard(_state.cells[index]);
              },
              child: ConstructorCellWidget(
                isBlack: _state.cells[index].isBlack,
                x: _state.cells[index].x,
                y: _state.cells[index].y,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
