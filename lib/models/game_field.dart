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

  List<Cell> tempLevel = [];
  bool canTap = true;

  late List<Cell> cells;
  // late int xLast;
  // late int yLast;
  int levelsNumber = 0;
  int level = 0;
  int movesNumber = 0;
  bool isWin = false;

  GameField() {
    cells = levels[level];
    setTempLevel();
    levelsNumber = levels.length;
  }

  void setTempLevel() {
    tempLevel =
        [...cells].map((cell) => Cell(cell.x, cell.y, cell.isBlack)).toList();
  }

  void loadTempLevel() {
    cells = [...tempLevel]
        .map((cell) => Cell(cell.x, cell.y, cell.isBlack))
        .toList();
  }

  void nextLevel() {
    isWin = false;
    movesNumber = 0;
    level++;
    cells = levels[level];
    setTempLevel();
    notifyListeners();
  }

  void restart() {
    isWin = false;
    movesNumber = 0;
    loadTempLevel();
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
    for (Cell cell in cells) {
      if (cell.isBlack) result++;
    }
    return result;
  }

  void pressCell(int x, int y) async {
    if (canTap) {
      getCellByCoordinates(x, y).switchIt();
      List<Cell> cellsToSwitch = nearestCells(x, y);
      movesNumber++;
      for (Cell cell in cellsToSwitch) {
        cell.switchIt();
      }
      notifyListeners();
      if (blackNumber() == cells.length) {
        isWin = true;
      }
      notifyListeners();
      canTap = false;
      Timer(const Duration(milliseconds: 301), () {
        canTap = true;
        notifyListeners();
      });
    }
  }

  Cell getCellByCoordinates(int x, int y) {
    return cells.firstWhere((cell) => cell.x == x && cell.y == y);
  }
}
