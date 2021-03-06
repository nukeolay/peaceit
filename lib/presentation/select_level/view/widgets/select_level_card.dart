import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:peaceit/core/theme/app_theme.dart';
import 'package:peaceit/domain/levels/entities/cell_entity.dart';

class SelectLevelCard extends StatelessWidget {
  const SelectLevelCard({
    required this.cells,
    required this.cellsQuantity,
    required this.levelNumber,
    required this.rating,
    required this.canBePlayed,
    Key? key,
  }) : super(key: key);

  final List<CellEntity> cells;
  final int cellsQuantity;
  final String levelNumber;
  final int rating;
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
              canBePlayed
                  ? GridView.builder(
                      physics: const BouncingScrollPhysics(),
                      itemCount: cells.length,
                      shrinkWrap: true,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: cellsQuantity,
                        crossAxisSpacing: 0,
                        mainAxisSpacing: 0,
                      ),
                      itemBuilder: (context, index) => Center(
                        child: Container(
                          decoration: BoxDecoration(
                            color: !cells[index].isPeace
                                ? context
                                    .read<AppTheme>()
                                    .cardFront
                                    .withOpacity(0.8)
                                : context
                                    .read<AppTheme>()
                                    .cardBack
                                    .withOpacity(0.8),
                            borderRadius: BorderRadius.circular(4.0),
                            boxShadow: [
                              BoxShadow(
                                color: context
                                    .read<AppTheme>()
                                    .cardBack
                                    .withOpacity(0.05),
                                blurRadius: 6.0,
                              ),
                            ],
                          ),
                          margin: const EdgeInsets.all(1.0),
                        ),
                      ),
                    )
                  : LayoutBuilder(
                      builder: (context, constraints) => Container(
                        constraints: BoxConstraints(
                          maxHeight: constraints.maxWidth,
                          maxWidth: constraints.maxWidth,
                        ),
                        width: double.infinity,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8.0),
                          color: context
                              .read<AppTheme>()
                              .background
                              .withOpacity(0.5),
                        ),
                        child: Text(
                          '?',
                          style: TextStyle(
                            color: context
                                .read<AppTheme>()
                                .buttonTextColor
                                .withOpacity(0.8),
                            fontSize: 30,
                          ),
                        ),
                      ),
                    ),
              LayoutBuilder(
                builder: (context, constraints) => Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Icon(
                      rating >= 1
                          ? Icons.star_rounded
                          : Icons.star_outline_rounded,
                      color: canBePlayed
                          ? context.read<AppTheme>().accentColor
                          : context.read<AppTheme>().cardBack,
                      size: constraints.maxWidth / 3 - 10,
                    ),
                    Icon(
                      rating >= 2
                          ? Icons.star_rounded
                          : Icons.star_outline_rounded,
                      color: canBePlayed
                          ? context.read<AppTheme>().accentColor
                          : context.read<AppTheme>().cardBack,
                      size: constraints.maxWidth / 3 - 10,
                    ),
                    Icon(
                      rating == 3
                          ? Icons.star_rounded
                          : Icons.star_outline_rounded,
                      color: canBePlayed
                          ? context.read<AppTheme>().accentColor
                          : context.read<AppTheme>().cardBack,
                      size: constraints.maxWidth / 3 - 10,
                    ),
                  ],
                ),
              ),
              Container(
                alignment: Alignment.center,
                child: Text(
                  levelNumber.toString(),
                  style: TextStyle(
                    color: context.read<AppTheme>().cardBack,
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
