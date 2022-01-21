import 'package:flutter/material.dart';
import 'package:makeitdark/routes/routes.dart';
import 'package:makeitdark/models/app_theme.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/bg.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 30.0),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Spacer(),
                TextButton(
                  child: Text(
                    '[make it dark]',
                    style: TextStyle(
                        color: context.read<AppTheme>().background,
                        fontSize: 30),
                  ),
                  onPressed: () {
                    Navigator.of(context).pushReplacementNamed(Routes.game);
                  },
                  style: ButtonStyle(
                    overlayColor: MaterialStateProperty.all(
                        context.read<AppTheme>().background),
                    backgroundColor: MaterialStateProperty.all(
                      context.read<AppTheme>().cardBack,
                    ),
                  ),
                ),
                const Spacer(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
