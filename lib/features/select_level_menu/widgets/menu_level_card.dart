import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:makeitdark/core/models/app_theme.dart';
import 'package:makeitdark/core/models/cell.dart';
import 'package:provider/src/provider.dart';

class MenuLevelCard extends StatelessWidget {
  const MenuLevelCard({
    required this.cells,
    required this.levelNumber,
    required this.rating,
    required this.canBePlayed,
    Key? key,
  }) : super(key: key);

  final List<Cell> cells;
  final int levelNumber;
  final int rating;
  final bool canBePlayed;

  @override
  Widget build(BuildContext context) {
    int length = sqrt(cells.length).toInt();

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
              GridView.builder(
                physics: const BouncingScrollPhysics(),
                itemCount: cells.length,
                shrinkWrap: true,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: length,
                  crossAxisSpacing: 0,
                  mainAxisSpacing: 0,
                ),
                itemBuilder: (context, index) => Center(
                  child: Container(
                    decoration: BoxDecoration(
                      color: cells[index].isBlack
                          ? context.read<AppTheme>().cardFront.withOpacity(0.8)
                          : context.read<AppTheme>().cardBack.withOpacity(0.8),
                      borderRadius: BorderRadius.circular(4.0),
                    ),
                    margin: const EdgeInsets.all(1.0),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Icon(
                    rating >= 1
                        ? Icons.star_rounded
                        : Icons.star_outline_rounded,
                    color: canBePlayed
                        ? context.read<AppTheme>().accentColor
                        : context.read<AppTheme>().buttonTextColor,
                    size: 20,
                  ),
                  Icon(
                    rating >= 2
                        ? Icons.star_rounded
                        : Icons.star_outline_rounded,
                    color: canBePlayed
                        ? context.read<AppTheme>().accentColor
                        : context.read<AppTheme>().buttonTextColor,
                    size: 20,
                  ),
                  Icon(
                    rating == 3
                        ? Icons.star_rounded
                        : Icons.star_outline_rounded,
                    color: canBePlayed
                        ? context.read<AppTheme>().accentColor
                        : context.read<AppTheme>().buttonTextColor,
                    size: 20,
                  ),
                ],
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
