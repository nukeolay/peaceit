import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import 'package:darkit/core/app_theme.dart';

class SelectLevelAppbar extends StatelessWidget {
  const SelectLevelAppbar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: IconButton(
            icon: Icon(
              Icons.arrow_back_ios_new_rounded,
              color: context.read<AppTheme>().buttonTextColor,
            ),
            onPressed: () {
              HapticFeedback.heavyImpact();
              Navigator.of(context).pop();
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            'ВЫБОР УРОВНЯ',
            style: TextStyle(
              color: context.read<AppTheme>().buttonTextColor,
              fontSize: 20,
            ),
            textAlign: TextAlign.center,
          ),
        ),
        const Padding(
          padding: EdgeInsets.all(8.0),
          child: IconButton(
            icon: Icon(
              Icons.delete_forever_rounded,
              color: Colors.transparent,
            ),
            onPressed: null,
          ),
        ),
      ],
    );
  }
}
