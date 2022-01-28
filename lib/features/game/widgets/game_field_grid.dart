import 'package:flutter/material.dart';
import 'package:darkit/core/models/cell.dart';
import 'package:darkit/features/game/widgets/cell_widget.dart';
import 'package:darkit/features/game/widgets/disable_multitouch.dart';

class GameFieldGrid extends StatelessWidget {
  const GameFieldGrid({
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
    return DisableMultitouchWidget(
      child: GridView.builder(
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
      ),
    );
  }
}