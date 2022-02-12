import 'package:darkit/domain/levels/entities/cell_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import 'package:darkit/core/routes/routes.dart';
import 'package:darkit/presentation/select_level/view_model/view_model.dart';
import 'package:darkit/presentation/select_level/widgets/select_level_card.dart';

class LevelsGrid extends StatelessWidget {
  const LevelsGrid({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _viewModel = context.watch<SelectLevelViewModel>();
    return GridView.builder(
      physics: const BouncingScrollPhysics(),
      itemCount: _viewModel.state.levelsNumber,
      shrinkWrap: true,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        childAspectRatio: 3 / 4,
        crossAxisSpacing: 5,
        mainAxisSpacing: 5,
      ),
      padding: const EdgeInsets.all(0.0),
      itemBuilder: (context, index) {
        final String _levelId = _viewModel.state.levels[index];
        final List<CellEntity> _cells = _viewModel.state.cells[index];
        final int _cellsQuantity = _viewModel.state.cellsQuantity[index];
        final String _levelNumber = _viewModel.state.levelNumber[index];
        final int _rating = _viewModel.state.rating[index];
        final bool _canBePlayed = _viewModel.state.canBePlayed[index];
        return Center(
          child: Container(
            padding: const EdgeInsets.all(8.0),
            child: GestureDetector(
              onTap: _viewModel.state.canBePlayed[index]
                  ? () {
                      HapticFeedback.heavyImpact();
                      Navigator.of(context)
                          .pushNamed(Routes.game, arguments: _levelId)
                          .whenComplete(_viewModel.update);
                      // TODO не обновляет список пройденных уровней поcле прохождения второго уровня подряд
                      // поэтому при нажатии на > после прохождения уровня, переходит не на следующий уровень, а в меню выбора уровней
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
