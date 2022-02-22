import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:darkit/core/theme/app_theme.dart';

class SelectChapterCard extends StatelessWidget {
  const SelectChapterCard({
    required this.chapterId,
    required this.completedRatio,
    required this.completedLevelsInChapter,
    required this.levelsInChapter,
    required this.canBePlayed,
    Key? key,
  }) : super(key: key);

  final String chapterId;
  final double completedRatio;
  final String completedLevelsInChapter;
  final String levelsInChapter;
  final bool canBePlayed;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8.0),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
        child: Container(
          padding: const EdgeInsets.all(8.0),
          color: canBePlayed
              ? context.read<AppTheme>().buttonTextColor.withOpacity(0.2)
              : context.read<AppTheme>().cardFront.withOpacity(0.2),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              LayoutBuilder(
                builder: (context, constraints) => Container(
                  constraints: BoxConstraints(
                    maxHeight: constraints.maxWidth,
                    maxWidth: constraints.maxWidth,
                  ),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.0),
                    color: context.read<AppTheme>().background.withOpacity(0.5),
                  ),
                  child: Text(
                    chapterId,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: canBePlayed
                          ? context
                              .read<AppTheme>()
                              .buttonTextColor
                              .withOpacity(0.8)
                          : context
                              .read<AppTheme>()
                              .buttonTextColor
                              .withOpacity(0.2),
                      fontSize: 30,
                    ),
                  ),
                ),
              ),
              Container(
                alignment: Alignment.center,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10.0),
                  child: LinearProgressIndicator(
                    value: completedRatio,
                    color: context.read<AppTheme>().accentColor,
                    backgroundColor:
                        context.read<AppTheme>().cardFront.withOpacity(0.3),
                  ),
                ),
              ),
              Container(
                alignment: Alignment.center,
                child: Text(
                  '$completedLevelsInChapter / $levelsInChapter',
                  style: TextStyle(
                    color: canBePlayed
                        ? context
                            .read<AppTheme>()
                            .buttonTextColor
                            .withOpacity(0.8)
                        : context
                            .read<AppTheme>()
                            .buttonTextColor
                            .withOpacity(0.2),
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
