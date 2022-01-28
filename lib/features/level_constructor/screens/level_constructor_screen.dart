import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:darkit/core/models/app_theme.dart';
import 'package:darkit/core/models/cell.dart';
import 'package:darkit/core/models/game.dart';
import 'package:darkit/core/models/game_field.dart';
import 'package:darkit/features/game/widgets/top_info_element.dart';
import 'package:darkit/features/level_constructor/widgets/constructor_game_field_grid.dart';
import 'package:provider/provider.dart';

class LevelConstructorScreen extends StatefulWidget {
  const LevelConstructorScreen({Key? key}) : super(key: key);

  @override
  State<LevelConstructorScreen> createState() => _LevelConstructorScreenState();
}

class _LevelConstructorScreenState extends State<LevelConstructorScreen> {
  late Game game;
  late GameField gameField;
  late List<Cell> cells;
  // late int currentLevel;
  late int movesNumber;
  late int length;
  List<Cell> inputCells = [];

  @override
  void didChangeDependencies() {
    game = Provider.of<Game>(context);
    gameField = game.gameField;
    cells = gameField.currentLevel;
    // currentLevel = game.currentLevelNumber;
    movesNumber = gameField.movesNumber;
    length = sqrt(cells.length).toInt();
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
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const TopInfoElement(
                            topData: 'НОВЫЙ',
                            bottomData: 'уровень',
                          ),
                          TopInfoElement(
                            topData: '$movesNumber',
                            bottomData: 'количество\nходов',
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: IconButton(
                              onPressed: () {
                                HapticFeedback.heavyImpact();
                                game.restartLevel();
                                setState(() {
                                  inputCells = [];
                                });
                              },
                              icon: Icon(
                                Icons.replay_rounded,
                                size: 30,
                                color: context.read<AppTheme>().buttonTextColor,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ConstructorGameFieldGrid(
                      cells: cells,
                      inputCells: inputCells,
                      length: length,
                      cellWidth: cellWidth,
                    ),
                  ],
                ),
                SizedBox(
                  height: 300,
                  child: ListView(
                    reverse: true,
                    children: [
                      ...inputCells.map(
                        (cell) => Text(
                          '${cell.x}, ${cell.y}',
                          style: const TextStyle(fontSize: 20),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
