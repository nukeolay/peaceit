import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:darkit/core/theme/app_theme.dart';

class CustomAlertDialog extends StatelessWidget {
  const CustomAlertDialog({
    Key? key,
    required this.width,
    required this.height,
    required this.text,
    this.icon,
    this.leftButtontext,
    this.leftButtonFunction,
    required this.rightButtontext,
    required this.rightButtonFunction,
    this.centerMainText = true,
  }) : super(key: key);

  final double width;
  final double height;
  final String text;
  final IconData? icon;
  final String? leftButtontext;
  final Function? leftButtonFunction;
  final String rightButtontext;
  final Function rightButtonFunction;
  final bool centerMainText;

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
                mainAxisSize: MainAxisSize.max,
                children: [
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                         if (icon != null)
                          Container(
                            padding: const EdgeInsets.all(12.0),
                            alignment: Alignment.center,
                            child: Icon(
                              icon,
                              color: context.read<AppTheme>().accentColor,
                              size: 40,
                            ),
                          ),
                        Container(
                          padding: const EdgeInsets.all(12.0),
                          alignment: Alignment.center,
                          child: Text(
                            text,
                            textAlign: centerMainText
                                ? TextAlign.center
                                : TextAlign.start,
                            style: TextStyle(
                              fontSize: 20,
                              color: context.read<AppTheme>().buttonTextColor,
                            ),
                          ),
                        ),
                       
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      if (leftButtontext != null)
                        Flexible(
                          fit: FlexFit.tight,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: OutlinedButton(
                              style: ButtonStyle(
                                side: MaterialStateProperty.all(
                                  BorderSide(
                                    color: context
                                        .read<AppTheme>()
                                        .buttonTextColor
                                        .withOpacity(0.8),
                                  ),
                                ),
                              ),
                              onPressed: () => {leftButtonFunction!()},
                              child: Text(
                                leftButtontext!,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.normal,
                                  color:
                                      context.read<AppTheme>().buttonTextColor,
                                ),
                              ),
                            ),
                          ),
                        ),
                      Flexible(
                        fit: leftButtontext != null
                            ? FlexFit.tight
                            : FlexFit.loose,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextButton(
                            onPressed: () => {rightButtonFunction()},
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(context
                                  .read<AppTheme>()
                                  .buttonTextColor
                                  .withOpacity(0.8)),
                            ),
                            child: Text(
                              rightButtontext,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 16,
                                color: context.read<AppTheme>().cardFront,
                              ),
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
