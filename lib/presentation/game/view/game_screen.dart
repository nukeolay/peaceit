import 'package:flutter/material.dart';
import 'package:peaceit/core/widgets/template_screen.dart';
import 'package:provider/provider.dart';

import 'package:peaceit/presentation/game/view/bottom_bar/bottom_bar.dart';
import 'package:peaceit/presentation/game/view/game_field/game_field.dart';
import 'package:peaceit/presentation/game/view/top_bar/top_bar.dart';
import 'package:peaceit/presentation/game/view_model/view_model.dart';
import 'package:peaceit/presentation/game/view/dialogs/pause_dialog.dart';

class GameScreen extends StatelessWidget {
  const GameScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String _levelId = ModalRoute.of(context)!.settings.arguments as String;
    return WillPopScope(
      onWillPop: () {
        showDialog(
          context: context,
          builder: (context) => PauseDialog(context),
        );
        return Future.value(false);
      },
      child: TemplateScreen(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 8.0,
              vertical: 10,
            ),
            child: ChangeNotifierProvider<GameViewModel>(
              create: (_) => GameViewModel(_levelId),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const TopBar(),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      GameField(),
                    ],
                  ),
                  const Spacer(),
                  const BottomBar(),
                ],
              ),
            ),
          ),
        ),
      ),

      // Future.delayed(Duration.zero).then((_) {
      //   precacheImage(
      //       const AssetImage(DefaultGameSettings.backGroundImage), context);
      // });
      // String _levelId = ModalRoute.of(context)!.settings.arguments as String;

      // return WillPopScope(
      //   onWillPop: () {
      //     showDialog(
      //       context: context,
      //       builder: (context) => PauseDialog(context),
      //     );
      //     return Future.value(false);
      //   },
      //   child: SelectScreen(
      //     child: SafeArea(
      //       child: Padding(
      //         padding: const EdgeInsets.symmetric(
      //           horizontal: 8.0,
      //           vertical: 10,
      //         ),
      //         child: ChangeNotifierProvider<GameViewModel>(
      //           create: (_) => GameViewModel(_levelId),
      //           child: Column(
      //             mainAxisSize: MainAxisSize.max,
      //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //             children: [
      //               const TopBar(),
      //               Column(
      //                 mainAxisAlignment: MainAxisAlignment.center,
      //                 children: const [
      //                   GameField(),
      //                 ],
      //               ),
      //               const Spacer(),
      //               const BottomBar(),
      //             ],
      //           ),
      //         ),
      //       ),
      //     ),
      //   ),

      // Scaffold(
      //   body: Stack(
      //     children: [
      //       Container(
      //         decoration: const BoxDecoration(
      //           image: DecorationImage(
      //             image: AssetImage(DefaultGameSettings.backGroundImage),
      //             fit: BoxFit.cover,
      //           ),
      //         ),
      //       ),
      //       Container(
      //         height: MediaQuery.of(context).size.width * 0.45,
      //         width: MediaQuery.of(context).size.width,
      //         decoration: const BoxDecoration(
      //           gradient: LinearGradient(
      //             begin: Alignment.topCenter,
      //             end: Alignment.bottomCenter,
      //             colors: [
      //               Color(0xCC000000),
      //               Color(0x00000000),
      //             ],
      //           ),
      //         ),
      //       ),
      //       SizedBox(
      //         child: SafeArea(
      //           child: Padding(
      //             padding: const EdgeInsets.symmetric(
      //               horizontal: 8.0,
      //               vertical: 10,
      //             ),
      //             child: ChangeNotifierProvider<GameViewModel>(
      //               create: (_) => GameViewModel(_levelId),
      //               child: Column(
      //                 mainAxisSize: MainAxisSize.max,
      //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //                 children: [
      //                   const TopBar(),
      //                   Column(
      //                     mainAxisAlignment: MainAxisAlignment.center,
      //                     children: const [
      //                       GameField(),
      //                     ],
      //                   ),
      //                   const Spacer(),
      //                   const BottomBar(),
      //                 ],
      //               ),
      //             ),
      //           ),
      //         ),
      //       ),
      //     ],
      //   ),
      // ),
    );
  }
}
