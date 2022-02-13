import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import 'package:darkit/core/theme/app_theme.dart';
import 'package:darkit/presentation/game/view_model/view_model.dart';

class SingleFlipButton extends StatelessWidget {
  const SingleFlipButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _viewModel = context.watch<GameViewModel>();
    final _state = _viewModel.state;
    return Column(
      children: [
        Text(
          _state.singleFlips,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 20,
            color: _state.canUseSingleFlips
                ? _state.isSingleFlipOn
                    ? context.read<AppTheme>().accentColor
                    : context.read<AppTheme>().buttonTextColor
                : context.read<AppTheme>().buttonTextColor.withOpacity(0.2),
          ),
        ),
        IconButton(
          tooltip: 'перевернуть одну ячейку',
          onPressed: _state.canUseSingleFlips
              ? () {
                  HapticFeedback.heavyImpact();
                  _viewModel.useSingleFlip();
                }
              : null,
          icon: Icon(
            Icons.flip,
            size: 30,
            color: _state.canUseSingleFlips
                ? _state.isSingleFlipOn
                    ? context.read<AppTheme>().accentColor
                    : context.read<AppTheme>().buttonTextColor
                : context.read<AppTheme>().buttonTextColor.withOpacity(0.2),
          ),
        ),
      ],
    );
  }
}
