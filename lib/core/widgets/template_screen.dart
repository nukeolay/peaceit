import 'package:flutter/material.dart';

import 'package:peaceit/core/constants/default_game_settings.dart';

class TemplateScreen extends StatelessWidget {
  final Widget child;
  const TemplateScreen({required this.child, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration.zero).then((_) {
      precacheImage(
          const AssetImage(DefaultGameSettings.backGroundImage), context);
    });

    return Scaffold(
      body: Stack(
        children: [
          Container(
            width: double.infinity,
            height: double.infinity,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage(DefaultGameSettings.backGroundImage),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Container(
            height: MediaQuery.of(context).size.width * 0.45,
            width: MediaQuery.of(context).size.width,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color(0xCC000000),
                  Color(0x00000000),
                ],
              ),
            ),
          ),
          SizedBox(
            width: double.infinity,
            height: double.infinity,
            child: child,
          ),
        ],
      ),
    );
  }
}
