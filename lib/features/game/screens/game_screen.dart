import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:makeitdark/core/models/cell.dart';
import 'package:makeitdark/core/models/game.dart';
import 'package:makeitdark/core/models/game_field.dart';
import 'package:makeitdark/core/routes/routes.dart';
import 'package:makeitdark/features/game/widgets/bottom_buttons.dart';
import 'package:makeitdark/features/game/widgets/game_field_grid.dart';
import 'package:makeitdark/features/game/widgets/top_info_element.dart';

class GameScreen extends StatefulWidget {
  const GameScreen({Key? key}) : super(key: key);

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  late Game _game;
  late String _levelId;
  late int _levelIndex;
  late GameField _gameField;
  late List<Cell> _cells;
  late int _movesNumber;
  late int _length;
  bool _isInit = true;

  @override
  void didChangeDependencies() {
    _levelId = ModalRoute.of(context)!.settings.arguments as String;
    _game = Provider.of<Game>(context);
    if (_isInit) {
      _game.setLevelById(_levelId);
      _isInit = false;
    }
    _gameField = _game.gameField;
    _cells = _gameField.currentLevel;
    _levelIndex = _game.levelIndexById(_levelId);
    _movesNumber = _gameField.movesNumber;
    _length = sqrt(_cells.length).toInt();

    bool isWin = Provider.of<Game>(context).isWin;
    if (isWin) {
      Future(() {
        Navigator.of(context)
            .pushReplacementNamed(Routes.levelCompleted, arguments: _levelId);
      });
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double cellWidth = width / _length - 10;
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/bg.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 8.0,
              vertical: 10,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TopInfoElement(
                            topData: '${_levelIndex + 1}',
                            bottomData: 'уровень',
                          ),
                          TopInfoElement(
                            topData: '$_movesNumber',
                            bottomData: 'количество\nходов',
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GameFieldGrid(
                      cells: _cells,
                      length: _length,
                      cellWidth: cellWidth,
                    ),
                  ],
                ),
                const Spacer(),
                const BottomButtons(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
