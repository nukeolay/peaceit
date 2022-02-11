import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import 'package:darkit/core/routes/routes.dart';
import 'package:darkit/features/levels/presentation/select_chapter_screen/view_models/select_chapter_view_model.dart';
import 'package:darkit/features/levels/presentation/select_chapter_screen/widgets/select_chapter_card.dart';

class ChaptersGrid extends StatelessWidget {
  const ChaptersGrid({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _viewModel = context.watch<SelectChapterViewModel>();
    return GridView.builder(
      physics: const BouncingScrollPhysics(),
      itemCount: _viewModel.chaptersNumber,
      shrinkWrap: true,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        childAspectRatio: 3 / 4,
        crossAxisSpacing: 5,
        mainAxisSpacing: 5,
      ),
      padding: const EdgeInsets.all(0.0),
      itemBuilder: (context, index) {
        String _chapterId = _viewModel.chapters[index];
        bool _canBePlayed = _viewModel.canBePlayed(_chapterId);
        return Center(
          child: Container(
            padding: const EdgeInsets.all(8.0),
            child: GestureDetector(
              onTap: _canBePlayed
                  ? () {
                      HapticFeedback.heavyImpact();
                      Navigator.of(context)
                          .pushNamed(Routes.selectLevelMenu,
                              arguments: _chapterId)
                          .then((_) => _viewModel.update());
                    }
                  : null,
              child: SelectChapterCard(
                chapterId: _chapterId,
                chapterProgress: _viewModel.completedRatio(_chapterId),
                completedLevelsInChapter:
                    _viewModel.completedLevels(_chapterId),
                levelsInChapter: _viewModel.levelsNumber(_chapterId),
                canBePlayed: _canBePlayed,
              ),
            ),
          ),
        );
      },
    );
  }
}
