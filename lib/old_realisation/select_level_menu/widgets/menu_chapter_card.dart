import 'dart:ui';

import 'package:darkit/old_realisation/models/app_theme.dart';
import 'package:flutter/material.dart';
// ignore: implementation_imports
import 'package:provider/src/provider.dart';

class MenuChapterCard extends StatelessWidget {
  const MenuChapterCard({
    required this.chapterId,
    required this.completedLevelsInChapter,
    required this.levelsInChapter,
    required this.canBePlayed,
    Key? key,
  }) : super(key: key);

  final String chapterId;
  final int completedLevelsInChapter;
  final int levelsInChapter;
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
              // GridView.builder(
              //   physics: const BouncingScrollPhysics(),
              //   itemCount: fieldWidth * fieldWidth,
              //   shrinkWrap: true,
              //   gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              //     crossAxisCount: fieldWidth,
              //     crossAxisSpacing: 0,
              //     mainAxisSpacing: 0,
              //   ),
              //   itemBuilder: (context, index) => Center(
              //     child: Container(
              //       decoration: BoxDecoration(
              //         color: canBePlayed
              //             ? context.read<AppTheme>().cardBack.withOpacity(0.5)
              //             : context.read<AppTheme>().cardFront.withOpacity(0.5),
              //         borderRadius: BorderRadius.circular(4.0),
              //         boxShadow: [
              //           BoxShadow(
              //             color: context
              //                 .read<AppTheme>()
              //                 .cardBack
              //                 .withOpacity(0.05),
              //             blurRadius: 6.0,
              //           ),
              //         ],
              //       ),
              //       margin: const EdgeInsets.all(1.0),
              //     ),
              //   ),
              // ),
              // Expanded(
              //   child:
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
              // ),
              Container(
                alignment: Alignment.center,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10.0),
                  child: LinearProgressIndicator(
                    value: completedLevelsInChapter / levelsInChapter,
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
