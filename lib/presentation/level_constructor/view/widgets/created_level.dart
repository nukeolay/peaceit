import 'package:flutter/material.dart';

import 'package:darkit/presentation/level_constructor/view_model/view_model_state.dart';

class CreatedLevel extends StatelessWidget {
  const CreatedLevel({
    Key? key,
    required ConstructorViewModelState state,
  }) : _state = state, super(key: key);

  final ConstructorViewModelState _state;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(right: 8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'x, y, isBlack',
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
            ),
          ),
          ..._state.cells.map(
            (cell) => Text(
              '${cell.x}, ${cell.y}${!cell.isBlack ? ', ${!cell.isBlack}' : ''}',
              style: const TextStyle(fontSize: 12),
              textAlign: TextAlign.start,
            ),
          ),
        ],
      ),
    );
  }
}
