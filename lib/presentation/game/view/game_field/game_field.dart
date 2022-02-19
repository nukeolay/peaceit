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
  late GameViewModel _viewModel;
  late GameViewModelState _state;
  late double _width;
  late double _cellWidth;
  // late List<bool> _cells;
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
      _width = MediaQuery.of(context).size.width;
      _cellWidth = _width / _state.fieldLength - 10;
      // _cells = _state.cells;
      _isInit = false;
    }

    WidgetsBinding.instance?.addPostFrameCallback((_) async {
      if (true) {
        if (_state.isWin) {
          String _newLevelId = (await Navigator.of(context)
              .pushNamed(Routes.levelCompleted, arguments: {
            'levelId': _state.levelId,
            'moves': _state.moves,
          })) as String;
          _isInit = true; // нужно чтобы пересчитывать размер ширины ячейки
          _viewModel.newInstance(_newLevelId);
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
            width: _cellWidth,
            height: _cellWidth,
            child: CellWidget(index),
          ),
        ),
      ),
    );
  }
}
