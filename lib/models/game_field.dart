import 'dart:async';

import 'package:flutter/material.dart';

import 'cell.dart';

class GameField with ChangeNotifier {
  List<List<Cell>> levels = [
    [
      Cell(1, 1, true),
      Cell(2, 1),
      Cell(3, 1, true),
      Cell(1, 2),
      Cell(2, 2),
      Cell(3, 2),
      Cell(1, 3, true),
      Cell(2, 3),
      Cell(3, 3, true),
    ],
    [
      Cell(1, 1, true),
      Cell(2, 1, true),
      Cell(3, 1, true),
      Cell(1, 2),
      Cell(2, 2, true),
      Cell(3, 2, true),
      Cell(1, 3),
      Cell(2, 3),
      Cell(3, 3, true),
    ],
    [
      Cell(1, 1),
      Cell(2, 1, true),
      Cell(3, 1, true),
      Cell(1, 2),
      Cell(2, 2),
      Cell(3, 2, true),
      Cell(1, 3),
      Cell(2, 3),
      Cell(3, 3),
    ],
    [
      Cell(1, 1),
      Cell(2, 1),
      Cell(3, 1),
      Cell(1, 2),
      Cell(2, 2),
      Cell(3, 2),
      Cell(1, 3),
      Cell(2, 3),
      Cell(3, 3),
    ],
    [
      Cell(1, 1),
      Cell(2, 1),
      Cell(3, 1),
      Cell(4, 1),
      Cell(1, 2),
      Cell(2, 2),
      Cell(3, 2, true),
      Cell(4, 2),
      Cell(1, 3),
      Cell(2, 3),
      Cell(3, 3),
      Cell(4, 3),
      Cell(1, 4, true),
      Cell(2, 4),
      Cell(3, 4),
      Cell(4, 4),
    ],
    [
      Cell(1, 1, true),
      Cell(2, 1),
      Cell(3, 1),
      Cell(4, 1, true),
      Cell(1, 2),
      Cell(2, 2),
      Cell(3, 2),
      Cell(4, 2),
      Cell(1, 3),
      Cell(2, 3),
      Cell(3, 3),
      Cell(4, 3),
      Cell(1, 4, true),
      Cell(2, 4),
      Cell(3, 4),
      Cell(4, 4, true),
    ],
    [
      Cell(1, 1),
      Cell(2, 1, true),
      Cell(3, 1, true),
      Cell(4, 1, true),
      Cell(5, 1, true),
      Cell(1, 2, true),
      Cell(2, 2),
      Cell(3, 2, true),
      Cell(4, 2, true),
      Cell(5, 2, true),
      Cell(1, 3, true),
      Cell(2, 3, true),
      Cell(3, 3),
      Cell(4, 3, true),
      Cell(5, 3, true),
      Cell(1, 4, true),
      Cell(2, 4, true),
      Cell(3, 4, true),
      Cell(4, 4),
      Cell(5, 4, true),
      Cell(1, 5, true),
      Cell(2, 5, true),
      Cell(3, 5, true),
      Cell(4, 5, true),
      Cell(5, 5),
    ],
    [
      Cell(1, 1, true),
      Cell(2, 1),
      Cell(3, 1),
      Cell(4, 1),
      Cell(5, 1),
      Cell(1, 2),
      Cell(2, 2, true),
      Cell(3, 2),
      Cell(4, 2),
      Cell(5, 2),
      Cell(1, 3),
      Cell(2, 3),
      Cell(3, 3, true),
      Cell(4, 3),
      Cell(5, 3),
      Cell(1, 4),
      Cell(2, 4),
      Cell(3, 4),
      Cell(4, 4),
      Cell(5, 4),
      Cell(1, 5),
      Cell(2, 5),
      Cell(3, 5),
      Cell(4, 5),
      Cell(5, 5, true),
    ],
    [
      Cell(1, 1, true),
      Cell(2, 1),
      Cell(3, 1),
      Cell(4, 1),
      Cell(5, 1),
      Cell(1, 2),
      Cell(2, 2, true),
      Cell(3, 2),
      Cell(4, 2),
      Cell(5, 2),
      Cell(1, 3),
      Cell(2, 3),
      Cell(3, 3, true),
      Cell(4, 3),
      Cell(5, 3),
      Cell(1, 4),
      Cell(2, 4),
      Cell(3, 4),
      Cell(4, 4, true),
      Cell(5, 4),
      Cell(1, 5),
      Cell(2, 5),
      Cell(3, 5),
      Cell(4, 5),
      Cell(5, 5, true),
    ]
  ];

  late List<Cell> currentLevel = [];
  bool canTap = true;
  // late int xLast;
  // late int yLast;
  int levelsNumber = 0;
  int level = 0;
  int movesNumber = 0;
  bool isWin = false;

  GameField() {
    setCurrentLevel();
    levelsNumber = levels.length;
  }

  void setCurrentLevel() {
    currentLevel = [...levels[level]]
        .map((cell) => Cell(cell.x, cell.y, cell.isBlack))
        .toList();
  }

  void nextLevel() {
    isWin = false;
    movesNumber = 0;
    level++;
    setCurrentLevel();
    notifyListeners();
  }

  void restart() {
    isWin = false;
    movesNumber = 0;
    setCurrentLevel();
    notifyListeners();
  }

  List<Cell> nearestCells(int x, int y) {
    List<Cell> result = [];
    try {
      result.add(getCellByCoordinates(x, y - 1));
    } catch (error) {}
    try {
      result.add(getCellByCoordinates(x, y + 1));
    } catch (error) {}
    try {
      result.add(getCellByCoordinates(x - 1, y));
    } catch (error) {}
    try {
      result.add(getCellByCoordinates(x + 1, y));
    } catch (error) {}
    return result;
  }

  int blackNumber() {
    int result = 0;
    for (Cell cell in currentLevel) {
      if (cell.isBlack) result++;
    }
    return result;
  }

  void pressCell(int x, int y) {
    if (canTap) {
      getCellByCoordinates(x, y).switchIt();
      List<Cell> cellsToSwitch = nearestCells(x, y);
      movesNumber++;
      for (Cell cell in cellsToSwitch) {
        cell.switchIt();
      }
      notifyListeners();

      canTap = false;
      Timer(const Duration(milliseconds: 350), () {
        canTap = true;
        if (blackNumber() == currentLevel.length) {
          isWin = true;
        }
        notifyListeners();
      });
    }
  }

  Cell getCellByCoordinates(int x, int y) {
    return currentLevel.firstWhere((cell) => cell.x == x && cell.y == y);
  }
}
