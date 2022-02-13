import 'dart:ui';

import 'package:darkit/core/constants/default_game_settings.dart';
import 'package:darkit/domain/levels/entities/cell_entity.dart';
import 'package:darkit/core/theme/app_theme.dart';
import 'package:darkit/old_realisation/models/game.dart';
import 'package:darkit/old_realisation/models/game_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:flip_card/flip_card.dart';
import 'package:flip_card/flip_card_controller.dart';

class CellWidget extends StatefulWidget {
  final CellEntity _cell;

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
  late final GameField _gameField;
  late bool _isBlack;
  late bool _isFlipped;
  bool _isInit = true;
  bool _canTap = true;
  bool _isSingleFlipOn = false;
  bool _isFlash = false;
  CellEntity? _solutionCell;

  @override
  void initState() {
    _controller = FlipCardController();
    super.initState();
  }

  @override
  void didChangeDependencies() {
    if (_isInit) {
      _game = Provider.of<Game>(context);
      _gameField = _game.gameField;
      _isBlack = widget._cell.isBlack;
      _isFlipped = widget._cell.isBlack;
      _isInit = false;
    }
    _isSingleFlipOn = _game.isSingleFlipOn;
    _solutionCell = _gameField.solutionCell;
    if (widget._cell == _solutionCell) {
      _isFlash = true;
      _canTap = true;
    } else {
      _isFlash = false;
      _canTap = false;
    }
    super.didChangeDependencies();
  }

  void flipCard() {
    if (_canTap) {
      HapticFeedback.heavyImpact();
      _gameField.pressCell(widget._cell.x, widget._cell.y);
      // поворачиваем карту только если сейчас не режим решения
      if (widget._cell == _solutionCell || _solutionCell == null) {
        _controller.toggleCard();
      }
    }
  }

  void flipThisCard() {
    _controller.toggleCard();
  }

  void singleFlipCard() async {
    if (_canTap) {
      HapticFeedback.heavyImpact();
      _gameField.singleFlip(widget._cell.x, widget._cell.y);
      _controller.toggleCard();
      await _game.singleFlipsDecrement();
      _game.isSingleFlipOn = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isFlipped != widget._cell.isBlack) {
      flipThisCard();
      _isFlipped = !_isFlipped;
    }
    _canTap = _gameField.canTap;
    return GestureDetector(
      onTap: () {
        _isSingleFlipOn ? singleFlipCard() : flipCard();
      },
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8.0),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
          child: FlipCard(
            speed: DefaultGameSettings.flipSpeed,
            controller: _controller,
            flipOnTouch: false,
            front: CustomCell(_isBlack, _isFlash),
            back: CustomCell(!_isBlack, _isFlash),
          ),
        ),
      ),
    );
  }
}

class CustomCell extends StatelessWidget {
  final bool _isBlack;
  final bool _isFlash;

  const CustomCell(
    this._isBlack,
    this._isFlash, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: _isFlash
            ? context.read<AppTheme>().accentColor.withOpacity(0.5)
            : _isBlack
                ? context.read<AppTheme>().cardFront.withOpacity(0.5)
                : context.read<AppTheme>().cardBack.withOpacity(0.5),
        boxShadow: [
          BoxShadow(
            color: context.read<AppTheme>().cardBack.withOpacity(0.05),
            blurRadius: 6.0,
          ),
        ],
      ),
    );
  }
}
