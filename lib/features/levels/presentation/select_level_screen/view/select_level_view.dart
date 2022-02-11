import 'package:darkit/features/levels/presentation/select_level_screen/widgets/select_level_body.dart';
import 'package:flutter/material.dart';

// ! TODO переделать на levels
class SelectLevelView extends StatelessWidget {
  const SelectLevelView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
        child: const SelectLevelBody(),
      ),
    );
  }
}
