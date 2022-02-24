import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flip_card/flip_card.dart';
import 'package:flip_card/flip_card_controller.dart';

import 'package:darkit/core/constants/default_game_settings.dart';
import 'package:darkit/core/theme/app_theme.dart';
import 'package:darkit/presentation/tutorial/view_model/view_model.dart';
import 'package:darkit/presentation/tutorial/view_model/view_model_state.dart';

class CellWidget extends StatefulWidget {
  final int _index;

  const CellWidget(
    this._index, {
    Key? key,
  }) : super(key: key);

  @override
  State<CellWidget> createState() => _CellWidgetState();
}

class _CellWidgetState extends State<CellWidget> {
  late TutorialViewModel _viewModel;
  late FlipCardController _controller;
  late TutorialViewModelState _state;
  late bool _isBlack;
  bool _isInit = true;

  @override
  void didChangeDependencies() {
    _viewModel = context.watch<TutorialViewModel>();
    _state = _viewModel.state;
    if (_isInit) {
      _controller = FlipCardController();
      _isBlack = _state.cells[widget._index];
      _isInit = false;
    }
    if (_state.cellsToFlip[widget._index]) _controller.toggleCard();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    bool _isFlash = widget._index == _state.flashCellIndex;
    return GestureDetector(
      onTap: () {
        _viewModel.flipCard(widget._index);
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
      child: _isFlash
          ? Icon(
              Icons.touch_app_rounded,
              color: context.read<AppTheme>().accentColor,
              size: 40,
            )
          : null,
    );
  }
}
