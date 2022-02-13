import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import 'package:darkit/core/theme/app_theme.dart';
import 'package:darkit/presentation/game/view_model/view_model.dart';
import 'package:darkit/presentation/game/view/bottom_bar/widgets/solution_dialog.dart';

class SolutionButton extends StatelessWidget {
  const SolutionButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _viewModel = context.watch<GameViewModel>();
    final _state = _viewModel.state;
    return Column(
      children: [
        Text(
          _state.solutionsNumber,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 20,
            color: _state.canUseSolution
                ? context.read<AppTheme>().buttonTextColor
                : context.read<AppTheme>().buttonTextColor.withOpacity(0.2),
          ),
        ),
        IconButton(
          tooltip: 'показать решение',
          onPressed: _state.canUseSolution
              ? () {
                  HapticFeedback.heavyImpact();
                  showDialog(
                    context: context,
                    builder: (context) => SolutionDialog(context),
                  );
                }
              : null,
          icon: Icon(
            Icons.lightbulb_outline_rounded,
            size: 30,
            color: _state.canUseSolution
                ? context.read<AppTheme>().buttonTextColor
                : context.read<AppTheme>().buttonTextColor.withOpacity(0.2),
          ),
        ),
      ],
    );
  }
}