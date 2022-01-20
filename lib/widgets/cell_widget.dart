import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:flip_card/flip_card.dart';
import 'package:flip_card/flip_card_controller.dart';

import 'package:makeitdark/models/app_theme.dart';
import 'package:makeitdark/models/cell.dart';
import 'package:makeitdark/models/game_field.dart';

class CellWidget extends StatefulWidget {
  final Cell _cell;

  const CellWidget(
    this._cell, {
    Key? key,
  }) : super(key: key);

  @override
  State<CellWidget> createState() => _CellWidgetState();
}

class _CellWidgetState extends State<CellWidget> {
  late FlipCardController _controller;
  late final GameField _gamefield;
  late bool _isBlack;
  late bool _isFlipped;
  bool _isInit = true;
  bool _canTap = true;

  @override
  void initState() {
    super.initState();
    _controller = FlipCardController();
  }

  void flipCard() {
    if (_canTap) {
      HapticFeedback.heavyImpact();
      _gamefield.pressCell(widget._cell.x, widget._cell.y);
      _controller.toggleCard();
    }
  }

  void flipThisCard() {
    _controller.toggleCard();
  }

  @override
  void didChangeDependencies() {
    if (_isInit) {
      _gamefield = Provider.of(context);
      _isBlack = widget._cell.isBlack;
      _isFlipped = widget._cell.isBlack;
      _isInit = false;
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    if (_isFlipped != widget._cell.isBlack) {
      flipThisCard();
      _isFlipped = !_isFlipped;
    }
    _canTap = _gamefield.canTap;
    return GestureDetector(
      onTap: () {
        flipCard();
      },
      child: FlipCard(
        speed: 300,
        controller: _controller,
        flipOnTouch: false,
        front: customCell(_isBlack),
        back: customCell(!_isBlack),
      ),
    );
  }

  Widget customCell(_isBlack) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8.0),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
        child: Container(
          decoration: BoxDecoration(
            color: _isBlack
                ? context.read<AppTheme>().cardFront.withOpacity(0.5)
                : context.read<AppTheme>().cardBack.withOpacity(0.5),
          ),
        ),
      ),
    );
  }
}
