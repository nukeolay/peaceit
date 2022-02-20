import 'package:flutter/material.dart';

import 'package:darkit/domain/levels/entities/cell_entity.dart';

class ResultBar extends StatelessWidget {
  final List<CellEntity> _cells;
  final List<CellEntity> _inputCells;
  const ResultBar(
    this._cells,
    this._inputCells, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 300,
      width: 300,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            height: 300,
            width: 200,
            child: ListView(
              children: [
                ..._cells.map(
                  (cell) => Text(
                    '${cell.x}, ${cell.y} ${cell.isBlack ? ', isBlack: ${cell.isBlack}' : ''}',
                    style: const TextStyle(fontSize: 12),
                    textAlign: TextAlign.start,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 300,
            width: 100,
            child: ListView(
              reverse: true,
              children: [
                ..._inputCells.map(
                  (cell) => Text(
                    '${cell.x}, ${cell.y}',
                    style: const TextStyle(fontSize: 12),
                    textAlign: TextAlign.end,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
