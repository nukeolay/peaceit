import 'dart:async';
import 'package:flutter/material.dart';

import 'package:darkit/features/levels/domain/entities/cell_entity.dart';

class GameField with ChangeNotifier {
  List<CellEntity> _currentLevel = [];
  List<CellEntity> _originalLevel = [];
  List<CellEntity> _originalSolutionCells = [];
  List<CellEntity> _solutionCells = [];
  late String _levelId;
  bool canTap = true;
  int movesNumber = 0;
  bool isAllBlack = false;
  CellEntity? solutionCell;

  GameField();

  void setLevel({
    required String levelId,
    required List<CellEntity> level,
    required List<CellEntity> solution,
  }) {
    _levelId = levelId;
    _currentLevel =
        [...level].map((cell) => CellEntity(cell.x, cell.y, cell.isBlack)).toList();
    _originalLevel =
        [...level].map((cell) => CellEntity(cell.x, cell.y, cell.isBlack)).toList();
    _originalSolutionCells = [...solution]
        .map((cell) => CellEntity(cell.x, cell.y, cell.isBlack))
        .toList();
    _solutionCells = [...solution]
        .map((cell) => CellEntity(cell.x, cell.y, cell.isBlack))
        .toList();
    movesNumber = 0;
    solutionCell = null;
    isAllBlack = false;
  }

  List<CellEntity> get currentLevel => _currentLevel;

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

  List<CellEntity> nearestCells(int x, int y) {
    List<CellEntity> result = [];
    try {
      result.add(_cellByCoordinates(x, y - 1));
    } catch (error) {}
    try {
      result.add(_cellByCoordinates(x, y + 1));
    } catch (error) {}
    try {
      result.add(_cellByCoordinates(x - 1, y));
    } catch (error) {}
    try {
      result.add(_cellByCoordinates(x + 1, y));
    } catch (error) {}
    return result;
  }

  int get blackNumber {
    int result = 0;
    for (CellEntity cell in _currentLevel) {
      if (cell.isBlack) result++;
    }
    return result;
  }

  void pressCell(int x, int y) {
    if (solutionCell == CellEntity(x, y) || solutionCell == null) {
      if (canTap) {
        _cellByCoordinates(x, y).switchIt();
        List<CellEntity> cellsToSwitch = nearestCells(x, y);
        movesNumber++;
        for (CellEntity cell in cellsToSwitch) {
          cell.switchIt();
        }
        if (solutionCell != null) {
          getSolution();
        }
        notifyListeners();
        canTap = false;
        Timer(const Duration(milliseconds: 310), () {
          canTap = true;
          if (blackNumber == _currentLevel.length) {
            isAllBlack = true;
          }
          notifyListeners();
        });
      }
    }
  }

  void singleFlip(int x, int y) {
    if (canTap) {
      _cellByCoordinates(x, y).switchIt();
      movesNumber++;
      notifyListeners();
      canTap = false;
      Timer(const Duration(milliseconds: 310), () {
        canTap = true;
        if (blackNumber == _currentLevel.length) {
          isAllBlack = true;
        }
        notifyListeners();
      });
    }
  }

  CellEntity _cellByCoordinates(int x, int y) {
    return _currentLevel.firstWhere((cell) => cell.x == x && cell.y == y);
  }
}
