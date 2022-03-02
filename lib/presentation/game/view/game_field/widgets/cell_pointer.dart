import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:darkit/core/theme/app_theme.dart';

class CellPointer extends StatefulWidget {
  const CellPointer({Key? key}) : super(key: key);

  @override
  _CellPointerState createState() => _CellPointerState();
}

class _CellPointerState extends State<CellPointer>
    with TickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    _animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 700));
    _animationController.repeat(reverse: true);
    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _animationController,
      child: LayoutBuilder(
        builder: ((context, constraints) => Icon(
              Icons.touch_app_rounded,
              color: context.read<AppTheme>().accentColor,
              size: constraints.maxHeight * 0.7,
            )),
      ),
    );
  }
}
