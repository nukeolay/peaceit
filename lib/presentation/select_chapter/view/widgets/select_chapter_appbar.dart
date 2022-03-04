import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:easy_localization/easy_localization.dart';

import 'package:darkit/core/theme/app_theme.dart';
import 'package:darkit/core/widgets/custom_alert_dialog.dart';
import 'package:darkit/presentation/select_chapter/view_model/view_model.dart';

class SelectChapterAppbar extends StatelessWidget {
  const SelectChapterAppbar({Key? key}) : super(key: key);

  void _showRemoveDataDialog(BuildContext context) {
    final _viewModel = context.read<SelectChapterViewModel>();
    showDialog(
      context: context,
      builder: (context) => CustomAlertDialog(
        text: 'reset_data_dialog'.tr(),
        leftButtontext: 'button_reset'.tr(),
        leftButtonFunction: () async {
          HapticFeedback.heavyImpact();
          await _viewModel.reset();
          Navigator.of(context).pop();
        },
        rightButtontext: 'button_cancel'.tr(),
        rightButtonFunction: () {
          HapticFeedback.heavyImpact();
          Navigator.of(context).pop();
        },
      ),
    );
  }

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
            'chapters'.tr(),
            style: TextStyle(
              color: context.read<AppTheme>().buttonTextColor,
              fontSize: 20,
            ),
            textAlign: TextAlign.center,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: IconButton(
            icon: Icon(
              Icons.delete_forever_rounded,
              color: context.read<AppTheme>().buttonTextColor,
            ),
            tooltip: 'tooltip_reset'.tr(),
            onPressed: () {
              HapticFeedback.heavyImpact();
              _showRemoveDataDialog(context);
            },
          ),
        ),
      ],
    );
  }
}
