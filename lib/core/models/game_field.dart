import 'dart:async';

import 'package:flutter/material.dart';

import 'cell.dart';

class GameField with ChangeNotifier {
  List<Cell> _currentLevel = [];
  List<Cell> _originalLevel = [];
  bool canTap = true;
  int movesNumber = 0;
  bool isAllBlack = false;

  GameField();

  void setLevel(List<Cell> level) {
    _currentLevel =
        [...level].map((cell) => Cell(cell.x, cell.y, cell.isBlack)).toList();
    _originalLevel =
        [...level].map((cell) => Cell(cell.x, cell.y, cell.isBlack)).toList();
    movesNumber = 0;
    isAllBlack = false;
  }

  List<Cell> get currentLevel => _currentLevel;

  void resetField() {
    isAllBlack = false;
    setLevel(_originalLevel);
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
    for (Cell cell in _currentLevel) {
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
      Timer(const Duration(milliseconds: 310), () {
        canTap = true;
        if (blackNumber() == _currentLevel.length) {
          isAllBlack = true;
        }
        notifyListeners();
      });
    }
  }

  void singleFlip(int x, int y) {
    if (canTap) {
      getCellByCoordinates(x, y).switchIt();
      movesNumber++;
      notifyListeners();
      canTap = false;
      Timer(const Duration(milliseconds: 310), () {
        canTap = true;
        if (blackNumber() == _currentLevel.length) {
          isAllBlack = true;
        }
        notifyListeners();
      });
    }
  }

  Cell getCellByCoordinates(int x, int y) {
    return _currentLevel.firstWhere((cell) => cell.x == x && cell.y == y);
  }
}
