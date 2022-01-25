import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:makeitdark/core/widgets/custom_alert_dialog.dart';
import 'package:provider/provider.dart';

import 'package:makeitdark/core/models/app_theme.dart';
import 'package:makeitdark/core/models/game.dart';
import 'package:makeitdark/core/models/levels.dart';
import 'package:makeitdark/core/models/user_data.dart';
import 'package:makeitdark/core/routes/routes.dart';
import 'package:makeitdark/features/select_level_menu/widgets/menu_level_card.dart';

class SelectLevelMenuScreen extends StatefulWidget {
  const SelectLevelMenuScreen({Key? key}) : super(key: key);

  @override
  State<SelectLevelMenuScreen> createState() => _SelectLevelMenuScreenState();
}

class _SelectLevelMenuScreenState extends State<SelectLevelMenuScreen> {
  late Game _game;

  @override
  void didChangeDependencies() {
    _game = Provider.of<Game>(context);
    super.didChangeDependencies();
  }

  void _showRemoveDataDialog() {
    double width = MediaQuery.of(context).size.width;
    showDialog(
      context: context,
      builder: (context) => CustomAlertDialog(
        height: width / 2,
        width: width / 1.1,
        text: 'Сбросить данные?\nВсе уровни нужно будет проходить заново.',
        leftButtontext: 'Сбросить',
        leftButtonFunction: () {
          HapticFeedback.heavyImpact();
          _game.removeData();
          Navigator.of(context).pop();
        },
        rightButtontext: 'Отмена',
        rightButtonFunction: () {
          HapticFeedback.heavyImpact();
          Navigator.of(context).pop();
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    UserData userData = _game.userData;

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
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: IconButton(
                        icon: Icon(
                          Icons.delete_forever_rounded,
                          color: context.read<AppTheme>().buttonTextColor,
                        ),
                        tooltip: 'сбросить данные',
                        onPressed: () {
                          HapticFeedback.heavyImpact();
                          _showRemoveDataDialog();
                        },
                      ),
                    ),
                  ],
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
                    bool canBePlayed =
                        userData.completedLevels.length + 1 >= index; // TODO заменить 50 на 1
                    return Center(
                      child: Container(
                        padding: const EdgeInsets.all(8.0),
                        child: GestureDetector(
                          onTap: canBePlayed
                              ? () {
                                  HapticFeedback.heavyImpact();
                                  _game.setLevelById(levelId);
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
