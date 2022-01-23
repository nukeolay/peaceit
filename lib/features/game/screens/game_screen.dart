import 'dart:math';

import 'package:flutter/material.dart';
import 'package:makeitdark/core/models/cell.dart';
import 'package:makeitdark/core/models/game.dart';
import 'package:makeitdark/core/models/game_field.dart';
import 'package:makeitdark/core/routes/routes.dart';
import 'package:makeitdark/features/game/widgets/bottom_buttons.dart';
import 'package:makeitdark/features/game/widgets/game_field_grid.dart';
import 'package:makeitdark/features/game/widgets/top_info_element.dart';
import 'package:provider/provider.dart';

class GameScreen extends StatefulWidget {
  const GameScreen({Key? key}) : super(key: key);

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  late Game game;
  late GameField gameField;
  late List<Cell> cells;
  late int currentLevel;
  late int movesNumber;
  late int length;

  @override
  void didChangeDependencies() {
    game = Provider.of<Game>(context);
    gameField = game.gameField;
    cells = gameField.currentLevel;
    currentLevel = game.currentLevelNumber;
    movesNumber = gameField.movesNumber;
    length = sqrt(cells.length).toInt();

    bool isWin = Provider.of<Game>(context).isWin;
    if (isWin) {
      Future(() {
        Navigator.of(context).pushReplacementNamed(Routes.levelCompleted);
      });
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double cellWidth = width / length - 10;
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
                            topData: '${currentLevel + 1}',
                            bottomData: 'уровень',
                          ),
                          TopInfoElement(
                            topData: '${game.singleFlips}',
                            bottomData: 'одиночные\nповороты',
                          ),
                          TopInfoElement(
                            topData: '$movesNumber',
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
                      cells: cells,
                      length: length,
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
