import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:makeitdark/core/models/app_theme.dart';
import 'package:makeitdark/core/models/game.dart';
import 'package:makeitdark/core/models/levels.dart';
import 'package:makeitdark/core/models/user_data.dart';
import 'package:makeitdark/core/routes/routes.dart';
import 'package:makeitdark/features/select_level_menu/widgets/menu_level_card.dart';
import 'package:provider/provider.dart';

class SelectLevelMenuScreen extends StatelessWidget {
  const SelectLevelMenuScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Game game = Provider.of<Game>(context, listen: false);
    UserData userData = game.userData;

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
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'выбор уровня',
                    style: TextStyle(
                      color: context.read<AppTheme>().buttonTextColor,
                      fontSize: 20,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                GridView.builder(
                  physics: const BouncingScrollPhysics(),
                  itemCount: Levels.allLevels.length,
                  shrinkWrap: true,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    childAspectRatio: 3 / 4,
                    crossAxisSpacing: 5,
                    mainAxisSpacing: 5,
                  ),
                  padding: const EdgeInsets.all(0.0),
                  itemBuilder: (context, index) {
                    String levelId = Levels.allLevels[index].id;
                    int rating =
                        userData.completedLevels[levelId]?.rating == null
                            ? 0
                            : userData.completedLevels[levelId]!.rating;
                    bool canBePlayed = userData.completedLevels.length >= index;
                    return Center(
                      child: Container(
                        padding: const EdgeInsets.all(8.0),
                        child: GestureDetector(
                          onTap: canBePlayed
                              ? () {
                                  HapticFeedback.heavyImpact();
                                  game.setLevelById(levelId);
                                  Navigator.of(context)
                                      .pushReplacementNamed(Routes.game);
                                }
                              : null,
                          child: MenuLevelCard(
                            cells: Levels.allLevels[index].cells,
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
