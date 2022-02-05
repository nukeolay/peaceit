import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:darkit/core/widgets/custom_alert_dialog.dart';
import 'package:darkit/features/select_level_menu/widgets/menu_chapter_card.dart';
import 'package:provider/provider.dart';

import 'package:darkit/core/models/app_theme.dart';
import 'package:darkit/core/models/game.dart';
import 'package:darkit/core/routes/routes.dart';

class SelectChapterMenuScreen extends StatelessWidget {
  const SelectChapterMenuScreen({Key? key}) : super(key: key);

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
        child: const ChapterSelect(),
      ),
    );
  }
}

class ChapterSelect extends StatefulWidget {
  const ChapterSelect({Key? key}) : super(key: key);

  @override
  _ChapterSelectState createState() => _ChapterSelectState();
}

class _ChapterSelectState extends State<ChapterSelect> {
  late Game _game;
  bool _isInit = true;

  @override
  void didChangeDependencies() {
    if (_isInit) {
      _isInit = false;
      _game = Provider.of<Game>(context);
      super.didChangeDependencies();
    }
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
        leftButtonFunction: () async {
          HapticFeedback.heavyImpact();
          await _game.removeData();
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
    return SafeArea(
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
                    'ВЫБОР ГЛАВЫ',
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
              itemCount: _game.chapters.length,
              shrinkWrap: true,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                childAspectRatio: 3 / 4,
                crossAxisSpacing: 5,
                mainAxisSpacing: 5,
              ),
              padding: const EdgeInsets.all(0.0),
              itemBuilder: (context, index) {
                String chapterId = _game.chapters[index].id;
                bool canBePlayed = _game.canBeChapterPlayed(chapterId);
                return Center(
                  child: Container(
                    padding: const EdgeInsets.all(8.0),
                    child: GestureDetector(
                      onTap: canBePlayed
                          ? () {
                              HapticFeedback.heavyImpact();
                              Navigator.of(context).pushNamed(
                                  Routes.selectLevelMenu,
                                  arguments: chapterId);
                            }
                          : null,
                      child: MenuChapterCard(
                        chapterId: chapterId,
                        completedLevelsInChapter: _game
                            .chapterByChapterId(chapterId)
                            .completedLevelsNumber,
                        levelsInChapter:
                            _game.chapterByChapterId(chapterId).levelsNumber,
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
    );
  }
}
