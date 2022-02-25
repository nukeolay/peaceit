import 'package:darkit/presentation/tutorial/view/dialogs/solution_tutorial_dialog.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:darkit/core/routes/routes.dart';
import 'package:darkit/presentation/tutorial/view_model/view_model.dart';
import 'package:darkit/presentation/tutorial/view_model/view_model_state.dart';
import 'package:darkit/presentation/tutorial/view/game_field/widgets/cell_widget.dart';
import 'package:darkit/presentation/tutorial/view/game_field/widgets/disable_multitouch.dart';
import 'package:darkit/presentation/tutorial/view/dialogs/intro_tutorial_dialog.dart';

class GameField extends StatefulWidget {
  const GameField({
    Key? key,
  }) : super(key: key);

  @override
  State<GameField> createState() => _GameFieldState();
}

class _GameFieldState extends State<GameField> {
  late TutorialViewModel _viewModel;
  late TutorialViewModelState _state;
  late double _width;
  late double _cellWidth;
  bool _isInit = true;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    _viewModel = context.watch<TutorialViewModel>();
    _state = _viewModel.state;
    if (_isInit) {
      _width = MediaQuery.of(context).size.width;
      _cellWidth = _width / _state.fieldLength * 0.92;
      _isInit = false;
    }

    WidgetsBinding.instance?.addPostFrameCallback((_) async {
      if (true) {
        if (_state.isWin) {
          // октрываем экран levelCompleted
          String? _newLevelId = (await Navigator.of(context)
              .pushNamed(Routes.tutorialLevelCompleted, arguments: {
            'levelId': _state.levelId,
            'nextLevelId': _state.nextLevelId,
          })) as String?;
          if (_newLevelId == null) {
            Navigator.of(context).pushReplacementNamed(
              Routes.selectChapterMenu,
            );
          } else {
            _isInit = true; // нужно чтобы пересчитывать размер ширины ячейки
            _viewModel.newInstance(_newLevelId);
          }
        }
      }
      if (_state.showIntroTutoriaDialog) {
        _viewModel.closeIntroTutorialDialog();
        showDialog(
          context: context,
          builder: (_) => IntroTutorialDialog(context),
        );
      }
      if (_state.showSolutionTutoriaDialog) {
        _viewModel.closeSolutionTutorialDialog();
        showDialog(
          context: context,
          builder: (_) => SolutionTutorialDialog(context),
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
              // передаю ключ, чтобы CellWidget создался заново, когда изменится конфигурация поля
              key: ValueKey('${_state.fieldLength}$index'),
            ),
          ),
        ),
      ),
    );
  }
}
