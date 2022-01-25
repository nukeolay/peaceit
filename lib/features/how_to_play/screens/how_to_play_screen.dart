import 'package:flutter/material.dart';
import 'package:makeitdark/core/models/app_theme.dart';
import 'package:provider/src/provider.dart';

class HowToPlayScreen extends StatefulWidget {
  const HowToPlayScreen({Key? key}) : super(key: key);

  @override
  State<HowToPlayScreen> createState() => _HowToPlayScreenState();
}

class _HowToPlayScreenState extends State<HowToPlayScreen> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/bg.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Expanded(
              child: Container(
                padding: const EdgeInsets.all(30.0),
                width: width,
                child: FittedBox(
                  child: Text(
                    'скоро тут будет инструкция',
                    style: TextStyle(
                      color: context
                          .read<AppTheme>()
                          .buttonTextColor
                          .withOpacity(0.5),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
