import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:easy_localization/easy_localization.dart';

import 'package:darkit/presentation/game/view/top_bar/widgets/top_info_element.dart';
import 'package:darkit/presentation/game/view_model/view_model.dart';

class TopBar extends StatelessWidget {
  const TopBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _state = context.watch<GameViewModel>().state;

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
                bottomData: 'level'.tr(),
              ),
              TopInfoElement(
                topData: _state.moves,
                bottomData: 'moves_number'.tr(),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
