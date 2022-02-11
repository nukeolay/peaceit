import 'package:flutter/material.dart';

import 'package:darkit/features/levels/presentation/select_chapter_screen/widgets/select_chapter_body.dart';

class SelectChapterView extends StatelessWidget {
  const SelectChapterView({Key? key}) : super(key: key);

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
        child: const SelectChapterBody(),
      ),
    );
  }
}
