import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import 'package:peaceit/core/theme/app_theme.dart';
import 'package:peaceit/presentation/game/view_model/view_model.dart';

class RestartButton extends StatelessWidget {
  const RestartButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _viewModel = context.watch<GameViewModel>();
    final _state = _viewModel.state;
    return IconButton(
      onPressed: _state.isSolutionOn
          ? null
          : () {
              HapticFeedback.heavyImpact();
              _viewModel.restartLevel();
            },
      icon: Icon(
        Icons.replay_rounded,
        size: 30,
        color: _state.isSolutionOn
            ? context.read<AppTheme>().buttonTextColor.withOpacity(0.2)
            : context.read<AppTheme>().buttonTextColor,
      ),
    );
  }
}
