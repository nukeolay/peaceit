import 'package:darkit/old_realisation/game/widgets/disable_multitouch.dart';
import 'package:darkit/old_realisation/level_constructor/widgets/constructor_cell_widget.dart';
import 'package:flutter/material.dart';

import 'package:darkit/features/levels/domain/entities/cell_entity.dart';

class ConstructorGameFieldGrid extends StatelessWidget {
  const ConstructorGameFieldGrid({
    Key? key,
    required this.cells,
    required this.inputCells,
    required this.length,
    required this.cellWidth,
  }) : super(key: key);

  final List<CellEntity> cells;
  final List<CellEntity> inputCells;

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
            child: ConstructorCellWidget(cells[index], inputCells),
          ),
        ),
      ),
    );
  }
}
