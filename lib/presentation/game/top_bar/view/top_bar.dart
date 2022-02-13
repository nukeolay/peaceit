import 'package:flutter/material.dart';

import 'package:darkit/presentation/game/top_bar/widgets/top_info_element.dart';

class TopBar extends StatelessWidget {
  const TopBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TopInfoElement(
                topData: '1',
                bottomData: 'уровень',
              ),
              TopInfoElement(
                topData: '1',
                bottomData: 'количество\nходов',
              ),
            ],
          ),
        ],
      ),
    );
  }
}
