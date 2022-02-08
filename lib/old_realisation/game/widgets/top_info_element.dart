import 'package:flutter/material.dart';

class TopInfoElement extends StatelessWidget {
  final String topData;
  final String bottomData;
  const TopInfoElement({
    required this.topData,
    required this.bottomData,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            topData,
            style: const TextStyle(
              fontSize: 25,
            ),
          ),
          Text(
            bottomData,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 14),
          ),
        ],
      ),
    );
  }
}
