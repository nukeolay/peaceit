import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:darkit/core/theme/app_theme.dart';

class InfoCard extends StatelessWidget {
  final Widget _widget;
  const InfoCard(this._widget, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8.0),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
        child: Container(
          padding: const EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            color: context.read<AppTheme>().cardBack.withOpacity(0.1),
            boxShadow: [
              BoxShadow(
                color: context.read<AppTheme>().cardBack.withOpacity(0.05),
                blurRadius: 6.0,
              ),
            ],
          ),
          child: _widget,
        ),
      ),
    );
  }
}
