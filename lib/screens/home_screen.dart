import 'dart:math';

import 'package:backward/models/cell.dart';
import 'package:backward/models/game_field.dart';
import 'package:backward/widgets/cell_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    GameField gameField = Provider.of<GameField>(context);
    List<Cell> cells = gameField.cells;
    int currentLevel = gameField.level;
    int movesNumber = gameField.movesNumber;
    int levelsNumber = gameField.levelsNumber;
    bool isWin = gameField.isWin;
    int length = sqrt(cells.length).toInt();
    double width = MediaQuery.of(context).size.width;
    double heigth = MediaQuery.of(context).size.height;
    double cellWidth = width / length - 10;
    return Scaffold(
      // appBar: AppBar(
      //   backgroundColor: context.read<AppTheme>().background,
      //   shadowColor: Colors.transparent,
      //   centerTitle: true,
      //   title: const Text('make it black!'),
      // ),
      body: Stack(
        children: [
          SizedBox(
            height: heigth,
            child: Image.asset(
              'assets/bg.png',
              fit: BoxFit.cover,
            ),
          ),
          SafeArea(
            child: isWin
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'ПОБЕДА',
                          style: TextStyle(fontSize: 30),
                        ),
                        Text(
                          'уровень пройден за $movesNumber хода(ов)',
                          style: const TextStyle(fontSize: 16),
                        ),
                        const SizedBox(height: 50),
                        currentLevel + 1 == levelsNumber
                            ? const Text(
                                'вы прошли игру',
                                style: TextStyle(color: Colors.white),
                              )
                            : TextButton(
                                onPressed: () => gameField.nextLevel(),
                                child: const Text(
                                  'следующий уровень',
                                  style: TextStyle(color: Colors.white),
                                ),
                              )
                      ],
                    ),
                  )
                : Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8.0,
                      vertical: 20,
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'backward\n[make it black]',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 30,
                            color: Colors.white.withOpacity(0.7),
                          ),
                        ),
                        GridView.builder(
                          physics: const BouncingScrollPhysics(),
                          itemCount: cells.length,
                          shrinkWrap: true,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: length,
                            crossAxisSpacing: 0,
                            mainAxisSpacing: 0,
                          ),
                          padding: const EdgeInsets.all(0.0),
                          itemBuilder: (context, index) => Center(
                            child: SizedBox(
                              width: cellWidth,
                              height: cellWidth,
                              child: CellWidget(
                                cells[index],
                                cellWidth,
                              ),
                            ),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
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
                                gameField.restart();
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
          )
        ],
      ),
    );
  }
}
