import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:peaceit/core/theme/app_theme.dart';

class RatingRow extends StatelessWidget {
  const RatingRow({
    Key? key,
    required this.rating,
  }) : super(key: key);

  final int rating;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          Icons.star_rounded,
          color: context.read<AppTheme>().accentColor,
          size: 36,
        ),
        Icon(
          rating >= 2 ? Icons.star_rounded : Icons.star_outline_rounded,
          color: context.read<AppTheme>().accentColor,
          size: 36,
        ),
        Icon(
          rating == 3 ? Icons.star_rounded : Icons.star_outline_rounded,
          color: context.read<AppTheme>().accentColor,
          size: 36,
        ),
      ],
    );
  }
}
