import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:easy_localization/easy_localization.dart';

import 'package:peaceit/core/theme/app_theme.dart';
import 'package:peaceit/presentation/game/view_model/view_model.dart';
import 'package:peaceit/presentation/game/view/dialogs/solution_dialog.dart';

class SolutionButton extends StatefulWidget {
  const SolutionButton({Key? key}) : super(key: key);

  @override
  State<SolutionButton> createState() => _SolutionButtonState();
}

class _SolutionButtonState extends State<SolutionButton>
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
    if (_state.flashSolutions) {
      _animationController.repeat(reverse: true);
    } else {
      _animationController.forward();
    }

    return FadeTransition(
      opacity: _animationController,
      child: Column(
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
            tooltip: 'tooltip_solution'.tr(),
            onPressed: _state.canUseSolution
                ? () {
                    HapticFeedback.heavyImpact();
                    showDialog(
                      context: context,
                      builder: (_) => SolutionDialog(context),
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
      ),
    );
  }
}
