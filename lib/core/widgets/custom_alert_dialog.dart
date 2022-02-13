import 'dart:ui';

import 'package:darkit/core/theme/app_theme.dart';
import 'package:flutter/material.dart';
// ignore: implementation_imports
import 'package:provider/src/provider.dart';


class CustomAlertDialog extends StatelessWidget {
  const CustomAlertDialog({
    Key? key,
    required this.width,
    required this.height,
    required this.text,
    required this.leftButtontext,
    required this.leftButtonFunction,
    required this.rightButtontext,
    required this.rightButtonFunction,
  }) : super(key: key);

  final double width;
  final double height;
  final String text;
  final String leftButtontext;
  final Function leftButtonFunction;
  final String rightButtontext;
  final Function rightButtonFunction;

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: Align(
        alignment: Alignment.center,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(8.0),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
            child: Container(
              height: height,
              width: width,
              padding: const EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                color: context.read<AppTheme>().cardBack.withOpacity(0.05),
                boxShadow: [
                  BoxShadow(
                    color: context.read<AppTheme>().cardBack.withOpacity(0.05),
                    blurRadius: 6.0,
                  ),
                ],
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.all(12.0),
                      alignment: Alignment.center,
                      child: Text(
                        text,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 20,
                          color: context.read<AppTheme>().buttonTextColor,
                        ),
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Flexible(
                        fit: FlexFit.tight,
                        child: TextButton(
                          onPressed: () => {leftButtonFunction()},
                          child: Text(
                            leftButtontext,
                            style: TextStyle(
                              fontSize: 16,
                              color: context.read<AppTheme>().buttonTextColor,
                            ),
                          ),
                        ),
                      ),
                      Flexible(
                        fit: FlexFit.tight,
                        child: TextButton(
                          onPressed: () => {rightButtonFunction()},
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(
                                context.read<AppTheme>().buttonTextColor.withOpacity(0.8)),
                          ),
                          child: Text(
                            rightButtontext,
                            style: TextStyle(
                              fontSize: 16,
                              color: context.read<AppTheme>().cardFront,
                            ),
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
