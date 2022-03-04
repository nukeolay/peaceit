import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:easy_localization/easy_localization.dart';

import 'package:darkit/core/theme/app_theme.dart';
import 'package:darkit/presentation/game/view_model/view_model.dart';

class SingleFlipButton extends StatefulWidget {
  const SingleFlipButton({Key? key}) : super(key: key);

  @override
  State<SingleFlipButton> createState() => _SingleFlipButtonState();
}

class _SingleFlipButtonState extends State<SingleFlipButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    _animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 300));
    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final _viewModel = context.watch<GameViewModel>();
    final _state = _viewModel.state;
    if (_state.flashSingleFlips) {
      _animationController.repeat(reverse: true);
    } else {
      _animationController.forward();
    }

    return FadeTransition(
      opacity: _animationController,
      child: Column(
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
            tooltip: 'tooltip_single_flip'.tr(),
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
      ),
    );
  }
}
