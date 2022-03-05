import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:flip_card/flip_card.dart';
import 'package:flip_card/flip_card_controller.dart';

import 'package:peaceit/core/constants/default_game_settings.dart';
import 'package:peaceit/core/theme/app_theme.dart';
import 'package:peaceit/presentation/game/view_model/view_model.dart';
import 'package:peaceit/presentation/game/view_model/view_model_state.dart';
import 'package:peaceit/presentation/game/view/game_field/widgets/cell_pointer.dart';

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
  late GameViewModel _viewModel;
  late FlipCardController _controller;
  late GameViewModelState _state;
  late bool _isBlack;
  bool _isInit = true;

  @override
  void didChangeDependencies() {
    _viewModel = context.watch<GameViewModel>();
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
        color: !_isBlack // ! TODO "!" чтобы поменять цвет
            ? context.read<AppTheme>().cardFront.withOpacity(0.5)
            : context.read<AppTheme>().cardBack.withOpacity(0.5),
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: _isBlack
                ? SvgPicture.asset('assets/dove.svg')
                : Opacity(
                    child: SvgPicture.asset('assets/tank.svg'),
                    opacity: 0.7,
                  ),
          ),
          if (_isFlash) const Center(child: CellPointer()),
        ],
      ),
    );
  }
}
