import 'package:peaceit/presentation/game/view/dialogs/intro_tutorial_dialog.dart';
import 'package:peaceit/presentation/game/view/dialogs/single_flip_tutorial_dialog.dart';
import 'package:peaceit/presentation/game/view/dialogs/solution_tutorial_dialog.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:peaceit/core/routes/routes.dart';
import 'package:peaceit/presentation/game/view/game_field/widgets/cell_widget.dart';
import 'package:peaceit/presentation/game/view/game_field/widgets/disable_multitouch.dart';
import 'package:peaceit/presentation/game/view_model/view_model.dart';
import 'package:peaceit/presentation/game/view_model/view_model_state.dart';

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
      _cellWidth = _width / _state.fieldLength * 0.92;
      _isInit = false;
    }

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      if (true) {
        if (_state.isWin) {
          // opening levelCompleted
          String? _newLevelId = (await Navigator.of(context)
              .pushNamed(Routes.levelCompleted, arguments: {
            'levelId': _state.levelId,
            'moves': _state.moves,
          })) as String?;
          if (_newLevelId != null) {
            _isInit = true; // needed to culculate cell size
            _viewModel.newInstance(_newLevelId);
          }
        }
      }
      if (_state.showTutorialIntro) {
        _viewModel.closeIntroTutorialDialog();
        showDialog(
          context: context,
          builder: (_) => IntroTutorialDialog(context),
        );
      }
      if (_state.showTutorialSolutions) {
        _viewModel.closeSolutionTutorialDialog();
        showDialog(
          context: context,
          builder: (_) => SolutionTutorialDialog(context),
        );
      }
      if (_state.showTutorialSingleFlips) {
        _viewModel.closeSingleFlipTutorialDialog();
        showDialog(
          context: context,
          builder: (_) => const SingleFlipTutorialDialog(),
        );
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
            child: CellWidget(
              index,
              // passing key, to create new CellWidget if gamefield size changes
              key: ValueKey('${_state.fieldLength}$index'),
            ),
          ),
        ),
      ),
    );
  }
}
