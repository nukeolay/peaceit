import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

import 'package:peaceit/presentation/level_constructor/view_model/view_model_state.dart';
import 'package:peaceit/presentation/game/view/top_bar/widgets/top_info_element.dart';

class TopBar extends StatelessWidget {
  const TopBar({
    Key? key,
    required String levelId,
    required ConstructorViewModelState state,
  })  : _levelId = levelId,
        _state = state,
        super(key: key);

  final String _levelId;
  final ConstructorViewModelState _state;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TopInfoElement(
            topData: _levelId,
            bottomData: 'level'.tr(),
          ),
          TopInfoElement(
            topData: _state.moves,
            bottomData: 'moves_number'.tr(),
          ),
        ],
      ),
    );
  }
}
