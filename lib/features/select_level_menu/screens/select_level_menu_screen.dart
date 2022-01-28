import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:darkit/core/models/level.dart';
import 'package:provider/provider.dart';

import 'package:darkit/core/models/app_theme.dart';
import 'package:darkit/core/models/game.dart';
import 'package:darkit/core/routes/routes.dart';
import 'package:darkit/features/select_level_menu/widgets/menu_level_card.dart';

class SelectLevelMenuScreen extends StatefulWidget {
  const SelectLevelMenuScreen({Key? key}) : super(key: key);

  @override
  State<SelectLevelMenuScreen> createState() => _SelectLevelMenuScreenState();
}

class _SelectLevelMenuScreenState extends State<SelectLevelMenuScreen> {
  late Game _game;
  late String _chapterId;

  @override
  void didChangeDependencies() {
    _game = Provider.of<Game>(context);
    _chapterId = ModalRoute.of(context)!.settings.arguments as String;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    List<Level> _levels = _game.levelsByChapterId(_chapterId);

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
            child: ListView(
              physics: const BouncingScrollPhysics(),
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: IconButton(
                        icon: Icon(
                          Icons.arrow_back_ios_new_rounded,
                          color: context.read<AppTheme>().buttonTextColor,
                        ),
                        onPressed: () {
                          HapticFeedback.heavyImpact();
                          Navigator.of(context).pop();
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'ВЫБОР УРОВНЯ',
                        style: TextStyle(
                          color: context.read<AppTheme>().buttonTextColor,
                          fontSize: 20,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: IconButton(
                        icon: Icon(
                          Icons.delete_forever_rounded,
                          color: Colors.transparent,
                        ),
                        onPressed: null,
                      ),
                    ),
                  ],
                ),
                GridView.builder(
                  physics: const BouncingScrollPhysics(),
                  itemCount: _levels.length,
                  shrinkWrap: true,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    childAspectRatio: 3 / 4,
                    crossAxisSpacing: 5,
                    mainAxisSpacing: 5,
                  ),
                  padding: const EdgeInsets.all(0.0),
                  itemBuilder: (context, index) {
                    String levelId = _levels[index].id;
                    int rating = _game.levelRatingById(levelId);
                    bool canBePlayed = _game.canBeLevelPlayed(levelId);
                    return Center(
                      child: Container(
                        padding: const EdgeInsets.all(8.0),
                        child: GestureDetector(
                          onTap: canBePlayed
                              ? () {
                                  HapticFeedback.heavyImpact();
                                  Navigator.of(context).pushNamed(Routes.game,
                                      arguments: levelId);
                                }
                              : null,
                          child: MenuLevelCard(
                            cells: _levels[index].cells,
                            levelNumber: index + 1,
                            rating: rating,
                            canBePlayed: canBePlayed,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
