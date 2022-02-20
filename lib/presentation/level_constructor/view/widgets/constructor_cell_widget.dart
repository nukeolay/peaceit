import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flip_card/flip_card.dart';

import 'package:darkit/core/constants/default_game_settings.dart';
import 'package:darkit/core/theme/app_theme.dart';

class ConstructorCellWidget extends StatelessWidget {
  final bool isBlack;
  final int x;
  final int y;

  const ConstructorCellWidget({
    required this.isBlack,
    required this.x,
    required this.y,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8.0),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
        child: FlipCard(
          speed: DefaultGameSettings.flipSpeed,
          flipOnTouch: false,
          front: CustomCell(isBlack, 'x: $x\ny: $y'),
          back: CustomCell(!isBlack, 'x: $x\ny: $y'),
        ),
      ),
    );
  }
}

class CustomCell extends StatelessWidget {
  final bool _isBlack;
  final String _text;

  const CustomCell(
    this._isBlack,
    this._text, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: _isBlack
            ? context.read<AppTheme>().cardFront.withOpacity(0.5)
            : context.read<AppTheme>().cardBack.withOpacity(0.5),
        boxShadow: [
          BoxShadow(
            color: context.read<AppTheme>().cardBack.withOpacity(0.05),
            blurRadius: 6.0,
          ),
        ],
      ),
      child: Text(
        _text,
        style: const TextStyle(fontSize: 20),
      ),
    );
  }
}
