import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:darkit/presentation/tutorial/view_model/view_model.dart';
import 'package:darkit/presentation/tutorial/view/top_bar/widgets/top_info_element.dart';

class TopBar extends StatelessWidget {
  const TopBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _state = context.watch<TutorialViewModel>().state;

    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TopInfoElement(
                topData: _state.levelNumber,
                bottomData: 'обучающий\nуровень',
              ),
              TopInfoElement(
                topData: _state.moves,
                bottomData: 'количество\nходов',
              ),
            ],
          ),
        ],
      ),
    );
  }
}
