import 'dart:math';

import 'package:darkit/features/levels/domain/entities/cell_entity.dart';
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
  late Game _game;
  late String _levelId;
  late GameField gameField;
  late List<CellEntity> cells;
  late int movesNumber;
  late int length;
  List<CellEntity> inputCells = [];
  bool _isInit = true;

  @override
  void didChangeDependencies() {
    _levelId = ModalRoute.of(context)!.settings.arguments as String;
    _game = Provider.of<Game>(context);
    if (_isInit) {
      _game.setLevelById(_levelId);
      _isInit = false;
    }
    gameField = _game.gameField;
    cells = gameField.currentLevel;
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
                        crossAxisAlignment: CrossAxisAlignment.center,
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
                                _game.restartLevel();
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
