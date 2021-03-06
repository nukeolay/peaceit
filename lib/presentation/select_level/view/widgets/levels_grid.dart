import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import 'package:peaceit/core/routes/routes.dart';
import 'package:peaceit/domain/levels/entities/cell_entity.dart';
import 'package:peaceit/presentation/select_level/view_model/view_model.dart';
import 'package:peaceit/presentation/select_level/view/widgets/select_level_card.dart';

class LevelsGrid extends StatelessWidget {
  const LevelsGrid({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _viewModel = context.watch<SelectLevelViewModel>();
    final _state = _viewModel.state;
    return GridView.builder(
      physics: const BouncingScrollPhysics(),
      itemCount: _state.levelsNumber,
      shrinkWrap: true,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        childAspectRatio: 3 / 4,
        crossAxisSpacing: 5,
        mainAxisSpacing: 5,
      ),
      padding: const EdgeInsets.all(0.0),
      itemBuilder: (context, index) {
        final String _levelId = _state.levels[index];
        final List<CellEntity> _cells = _state.cells[index];
        final int _cellsQuantity = _state.cellsQuantity[index];
        final String _levelNumber = _state.levelNumber[index];
        final int _rating = _state.rating[index];
        final bool _canBePlayed = _state.canBePlayed[index];
        return Center(
          child: Container(
            padding: const EdgeInsets.all(8.0),
            child: GestureDetector(
              onTap: _state.canBePlayed[index]
                  ? () {
                      HapticFeedback.heavyImpact();
                      Navigator.of(context)
                          .pushNamed(Routes.game, arguments: _levelId)
                          .whenComplete(_viewModel.update);
                    }
                  : null,
              child: SelectLevelCard(
                cells: _cells,
                cellsQuantity: _cellsQuantity,
                levelNumber: _levelNumber,
                rating: _rating,
                canBePlayed: _canBePlayed,
              ),
            ),
          ),
        );
      },
    );
  }
}
