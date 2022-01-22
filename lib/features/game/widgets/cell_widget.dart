import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:makeitdark/core/models/app_theme.dart';
import 'package:makeitdark/core/models/cell.dart';
import 'package:makeitdark/core/models/game.dart';
import 'package:makeitdark/core/models/game_field.dart';
import 'package:provider/provider.dart';
import 'package:flip_card/flip_card.dart';
import 'package:flip_card/flip_card_controller.dart';

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
  late final Game _game;
  late final GameField _gamefield;
  late bool _isBlack;
  late bool _isFlipped;
  bool _isInit = true;
  bool _canTap = true;
  bool _isSingleFlipOn = false;

  @override
  void initState() {
    super.initState();
    _controller = FlipCardController();
  }

  @override
  void didChangeDependencies() {
    if (_isInit) {
      _game = Provider.of<Game>(context);
      _gamefield = _game.gameField;
      _isBlack = widget._cell.isBlack;
      _isFlipped = widget._cell.isBlack;
      _isInit = false;
    }
    _isSingleFlipOn = _game.isSingleFlipOn;
    super.didChangeDependencies();
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

  void singleFlipCard() {
    if (_canTap) {
      HapticFeedback.heavyImpact();
      _gamefield.singleFlip(widget._cell.x, widget._cell.y);
      _controller.toggleCard();
      _game.isSingleFlipOn = false;
      _game.singleFlips--;
    }
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
        _isSingleFlipOn ? singleFlipCard() : flipCard();
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
