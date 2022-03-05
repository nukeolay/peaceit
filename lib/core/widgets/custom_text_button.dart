import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:peaceit/core/theme/app_theme.dart';

class CustomTextButton extends StatelessWidget {
  const CustomTextButton({
    required this.text,
    required this.function,
    Key? key,
  }) : super(key: key);

  final String text;
  final Function function;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return ClipRRect(
      borderRadius: BorderRadius.circular(8.0),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
        child: Container(
          width: width * 0.6,
          padding: const EdgeInsets.all(0.0),
          margin: const EdgeInsets.all(0.0),
          decoration: BoxDecoration(
            color: context.read<AppTheme>().cardBack.withOpacity(0.5),
            boxShadow: [
              BoxShadow(
                color: context.read<AppTheme>().cardBack.withOpacity(0.05),
                blurRadius: 6.0,
              ),
            ],
          ),
          child: TextButton(
            child: Text(
              text,
              style: TextStyle(
                  color: context.read<AppTheme>().cardFront, fontSize: 26),
            ),
            onPressed: () => {function()},
            style: ButtonStyle(
              overlayColor: MaterialStateProperty.all(
                  context.read<AppTheme>().accentColor),
              backgroundColor: MaterialStateProperty.all(
                Colors.transparent,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
