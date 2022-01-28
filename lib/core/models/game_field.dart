import 'dart:async';

import 'package:flutter/material.dart';

import 'cell.dart';

class GameField with ChangeNotifier {
  List<Cell> _currentLevel = [];
  List<Cell> _originalLevel = [];
  List<Cell> _originalSolutionCells = [];
  List<Cell> _solutionCells = [];
  late String _levelId;
  bool canTap = true;
  int movesNumber = 0;
  bool isAllBlack = false;
  Cell? solutionCell;

  GameField();

  void setLevel({
    required String levelId,
    required List<Cell> level,
    required List<Cell> solution,
  }) {
    _levelId = levelId;
    _currentLevel =
        [...level].map((cell) => Cell(cell.x, cell.y, cell.isBlack)).toList();
    _originalLevel =
        [...level].map((cell) => Cell(cell.x, cell.y, cell.isBlack)).toList();
    _originalSolutionCells = [...solution]
        .map((cell) => Cell(cell.x, cell.y, cell.isBlack))
        .toList();
    _solutionCells = [...solution]
        .map((cell) => Cell(cell.x, cell.y, cell.isBlack))
        .toList();
    movesNumber = 0;
    solutionCell = null;
    isAllBlack = false;
  }

  List<Cell> get currentLevel => _currentLevel;

  String get levelId => _levelId;

  void resetField() {
    isAllBlack = false;
    setLevel(
      levelId: _levelId,
      level: _originalLevel,
      solution: _originalSolutionCells,
    );
    solutionCell = null;
    notifyListeners();
  }

  void getSolution() {
    if (_solutionCells.isNotEmpty) {
      solutionCell = _solutionCells.removeAt(0);
    } else {
      solutionCell = null;
    }
  }

  List<Cell> nearestCells(int x, int y) {
    List<Cell> result = [];
    try {
      result.add(_getCellByCoordinates(x, y - 1));
    } catch (error) {}
    try {
      result.add(_getCellByCoordinates(x, y + 1));
    } catch (error) {}
    try {
      result.add(_getCellByCoordinates(x - 1, y));
    } catch (error) {}
    try {
      result.add(_getCellByCoordinates(x + 1, y));
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
    if (solutionCell == Cell(x, y) || solutionCell == null) {
      if (canTap) {
        _getCellByCoordinates(x, y).switchIt();
        List<Cell> cellsToSwitch = nearestCells(x, y);
        movesNumber++;
        for (Cell cell in cellsToSwitch) {
          cell.switchIt();
        }
        if (solutionCell != null) {
          getSolution();
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
  }

  void singleFlip(int x, int y) {
    if (canTap) {
      _getCellByCoordinates(x, y).switchIt();
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

  Cell _getCellByCoordinates(int x, int y) {
    return _currentLevel.firstWhere((cell) => cell.x == x && cell.y == y);
  }
}
