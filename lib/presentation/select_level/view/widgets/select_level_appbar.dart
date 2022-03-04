import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:easy_localization/easy_localization.dart';

import 'package:darkit/core/theme/app_theme.dart';

class SelectLevelAppbar extends StatelessWidget {
  const SelectLevelAppbar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            width: constraints.maxWidth * 0.2,
            padding: const EdgeInsets.all(8.0),
            child: FittedBox(
              fit: BoxFit.fitWidth,
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
          ),
          Container(
            width: constraints.maxWidth * 0.6,
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'levels'.tr(),
              style: TextStyle(
                color: context.read<AppTheme>().buttonTextColor,
              fontSize: constraints.maxWidth * 0.06,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          Container(
            width: constraints.maxWidth * 0.2,
            padding: const EdgeInsets.all(8.0),
            child: const FittedBox(
              fit: BoxFit.fitWidth,
              child: IconButton(
                icon: Icon(
                  Icons.delete_forever_rounded,
                  color: Colors.transparent,
                ),
                onPressed: null,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
