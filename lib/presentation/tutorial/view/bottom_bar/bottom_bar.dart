import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:darkit/core/theme/app_theme.dart';
import 'package:darkit/presentation/tutorial/view/bottom_bar/widgets/pause_button.dart';
import 'package:darkit/presentation/tutorial/view/bottom_bar/widgets/single_flip_button.dart';
import 'package:darkit/presentation/tutorial/view/bottom_bar/widgets/solution_button.dart';
import 'package:darkit/presentation/tutorial/view/bottom_bar/widgets/restart_button.dart';

class BottomBar extends StatelessWidget {
  const BottomBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        const Padding(
          padding: EdgeInsets.all(8.0),
          child: PauseButton(),
        ),
        ClipRRect(
          borderRadius: BorderRadius.circular(8.0),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
            child: Container(
              padding: const EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                color: context.read<AppTheme>().cardBack.withOpacity(0.1),
                boxShadow: [
                  BoxShadow(
                    color: context.read<AppTheme>().cardBack.withOpacity(0.05),
                    blurRadius: 6.0,
                  ),
                ],
              ),
              child: Row(
                children: const [
                  SingleFlipButton(),
                  SizedBox(width: 20),
                  SolutionButton(),
                ],
              ),
            ),
          ),
        ),
        const Padding(
          padding: EdgeInsets.all(8.0),
          child: RestartButton(),
        ),
      ],
    );
  }
}
