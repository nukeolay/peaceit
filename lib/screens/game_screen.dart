import 'dart:math';

import 'package:makeitdark/models/app_theme.dart';
import 'package:makeitdark/models/cell.dart';
import 'package:makeitdark/models/game.dart';
import 'package:makeitdark/models/game_field.dart';
import 'package:makeitdark/routes/routes.dart';
import 'package:makeitdark/widgets/cell_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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

  void _showPauseDialog() {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: context.read<AppTheme>().background.withOpacity(0.6),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
        title: Text(
          'ПАУЗА',
          textAlign: TextAlign.center,
          style: TextStyle(color: context.read<AppTheme>().buttonTextColor),
        ),
        elevation: 0,
        actionsAlignment: MainAxisAlignment.spaceBetween,
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: TextButton(
              onPressed: () {
                HapticFeedback.heavyImpact();
                Navigator.of(ctx).pop();
              },
              child: Text(
                'Выйти',
                style: TextStyle(
                  color: context.read<AppTheme>().buttonTextColor,
                ),
              ),
            ),
          ),
          TextButton(
            onPressed: () {
              HapticFeedback.heavyImpact();
              Navigator.of(ctx).pop();
            },
            child: Text(
              'Продолжить',
              style: TextStyle(
                color: context.read<AppTheme>().buttonTextColor,
              ),
            ),
          ),
        ],
      ),
    );
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
              vertical: 20,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GameFieldView(
                        cells: cells,
                        length: length,
                        cellWidth: cellWidth,
                      ),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    IconButton(
                      onPressed: () {
                        HapticFeedback.heavyImpact();
                        _showPauseDialog();
                      },
                      icon: const Icon(
                        Icons.pause_rounded,
                        size: 30,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      'уровень: ${currentLevel + 1}',
                      style: const TextStyle(
                        fontSize: 14,
                      ),
                    ),
                    Text(
                      'ходы: $movesNumber',
                      style: const TextStyle(
                        fontSize: 14,
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        HapticFeedback.heavyImpact();
                        game.restart();
                      },
                      icon: const Icon(
                        Icons.replay_rounded,
                        size: 30,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class GameFieldView extends StatelessWidget {
  const GameFieldView({
    Key? key,
    required this.cells,
    required this.length,
    required this.cellWidth,
  }) : super(key: key);

  final List<Cell> cells;
  final int length;
  final double cellWidth;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      physics: const BouncingScrollPhysics(),
      itemCount: cells.length,
      shrinkWrap: true,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: length,
        crossAxisSpacing: 0,
        mainAxisSpacing: 0,
      ),
      padding: const EdgeInsets.all(0.0),
      itemBuilder: (context, index) => Center(
        child: SizedBox(
          width: cellWidth,
          height: cellWidth,
          child: CellWidget(cells[index]),
        ),
      ),
    );
  }
}
