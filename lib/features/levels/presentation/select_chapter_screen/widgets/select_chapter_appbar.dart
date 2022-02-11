import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import 'package:darkit/core/app_theme.dart';
import 'package:darkit/core/widgets/custom_alert_dialog.dart';
import 'package:darkit/features/levels/presentation/select_chapter_screen/view_models/select_chapter_view_model.dart';

class SelectChapterAppbar extends StatelessWidget {
  const SelectChapterAppbar({Key? key}) : super(key: key);

  void _showRemoveDataDialog(BuildContext context) {
    double _width = MediaQuery.of(context).size.width;
    final _viewModel = context.read<SelectChapterViewModel>();
    showDialog(
      context: context,
      builder: (context) => CustomAlertDialog(
        height: _width / 2,
        width: _width / 1.1,
        text: 'Сбросить данные?\nВсе уровни нужно будет проходить заново.',
        leftButtontext: 'Сбросить',
        leftButtonFunction: () async {
          HapticFeedback.heavyImpact();
          await _viewModel.reset();
          Navigator.of(context).pop();
        },
        rightButtontext: 'Отмена',
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
            'ВЫБОР ГЛАВЫ',
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
            tooltip: 'сбросить данные',
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
