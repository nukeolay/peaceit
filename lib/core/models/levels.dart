import 'package:darkit/core/models/cell.dart';
import 'package:darkit/core/models/level.dart';

class Chapter {
  String id;
  List<Level> levels;

  Chapter({
    required this.id,
    required this.levels,
  });

  int get levelsNumber => levels.length;

  int get completedLevelsNumber =>
      levels.where((level) => level.rating > 0).length;

  double get completedRatio => completedLevelsNumber / levelsNumber;

  int levelIndexById(String levelId) {
    return levels.indexOf(levels.firstWhere((level) => level.id == levelId));
  }
}

class Levels {
  List<Level> levelsByChapterId(String chapterId) {
    return allLevels.where((level) => level.chapterId == chapterId).toList();
  }

  Level levelById(String levelId) {
    return allLevels.firstWhere((level) => level.id == levelId);
  }

  String chapterIdByLevelId(String levelId) {
    return allLevels.firstWhere((level) => level.id == levelId).chapterId;
  }

  List<Chapter> get chapters {
    List<Chapter> chapters = [];
    List<String> chapterIds = [];
    for (Level level in allLevels) {
      if (!chapterIds.contains(level.chapterId)) {
        chapterIds.add(level.chapterId);
        chapters.add(Chapter(id: level.chapterId, levels: [level]));
      } else {
        chapters
            .firstWhere((chapter) => chapter.id == level.chapterId)
            .levels
            .add(level);
      }
    }
    return chapters;
  }

  Chapter chapterById(String chapterId) {
    return chapters.firstWhere((chapter) => chapter.id == chapterId);
  }

  List<Level> allLevels = [
    // ------------------- CHAPTER 1 -------------------
    Level(id: 'x3c1n1', chapterId: '1', bestResult: 1, goodResult: 4, cells: [
      Cell(1, 1, true),
      Cell(2, 1),
      Cell(3, 1, true),
      Cell(1, 2),
      Cell(2, 2),
      Cell(3, 2),
      Cell(1, 3, true),
      Cell(2, 3),
      Cell(3, 3, true),
    ], solution: [
      Cell(2, 2),
    ]),
    Level(id: 'x3c1n2', chapterId: '1', bestResult: 1, goodResult: 4, cells: [
      Cell(1, 1, true),
      Cell(2, 1, true),
      Cell(3, 1, true),
      Cell(1, 2),
      Cell(2, 2, true),
      Cell(3, 2, true),
      Cell(1, 3),
      Cell(2, 3),
      Cell(3, 3, true),
    ], solution: [
      Cell(1, 3),
    ]),
    Level(id: 'x3c1n3', chapterId: '1', bestResult: 1, goodResult: 4, cells: [
      Cell(1, 1, true),
      Cell(2, 1, true),
      Cell(3, 1, true),
      Cell(1, 2, true),
      Cell(2, 2),
      Cell(3, 2, true),
      Cell(1, 3),
      Cell(2, 3),
      Cell(3, 3),
    ], solution: [
      Cell(2, 3),
    ]),
    Level(id: 'x4c1n4', chapterId: '1', bestResult: 1, goodResult: 4, cells: [
      Cell(1, 1, true),
      Cell(2, 1),
      Cell(3, 1, true),
      Cell(4, 1, true),
      Cell(1, 2),
      Cell(2, 2),
      Cell(3, 2),
      Cell(4, 2, true),
      Cell(1, 3, true),
      Cell(2, 3),
      Cell(3, 3, true),
      Cell(4, 3, true),
      Cell(1, 4, true),
      Cell(2, 4, true),
      Cell(3, 4, true),
      Cell(4, 4, true),
    ], solution: [
      Cell(2, 2),
    ]),
    Level(id: 'x4c1n5', chapterId: '1', bestResult: 1, goodResult: 4, cells: [
      Cell(1, 1, true),
      Cell(2, 1, true),
      Cell(3, 1, true),
      Cell(4, 1, true),
      Cell(1, 2, true),
      Cell(2, 2, true),
      Cell(3, 2, true),
      Cell(4, 2, true),
      Cell(1, 3, true),
      Cell(2, 3),
      Cell(3, 3, true),
      Cell(4, 3, true),
      Cell(1, 4),
      Cell(2, 4),
      Cell(3, 4),
      Cell(4, 4, true),
    ], solution: [
      Cell(2, 4),
    ]),
    Level(id: 'x3c1n6', chapterId: '1', bestResult: 2, goodResult: 5, cells: [
      Cell(1, 1),
      Cell(2, 1),
      Cell(3, 1),
      Cell(1, 2, true),
      Cell(2, 2, true),
      Cell(3, 2, true),
      Cell(1, 3),
      Cell(2, 3),
      Cell(3, 3),
    ], solution: [
      Cell(2, 1),
      Cell(2, 3),
    ]),

    // ------------------- CHAPTER 2 -------------------

    Level(id: 'x4c2n1', chapterId: '2', bestResult: 2, goodResult: 5, cells: [
      Cell(1, 1),
      Cell(2, 1, true),
      Cell(3, 1, true),
      Cell(4, 1),
      Cell(1, 2),
      Cell(2, 2),
      Cell(3, 2),
      Cell(4, 2),
      Cell(1, 3),
      Cell(2, 3, true),
      Cell(3, 3, true),
      Cell(4, 3),
      Cell(1, 4, true),
      Cell(2, 4, true),
      Cell(3, 4, true),
      Cell(4, 4, true),
    ], solution: [
      Cell(1, 2),
      Cell(4, 2),
    ]),
    Level(id: 'x4c2n2', chapterId: '2', bestResult: 2, goodResult: 5, cells: [
      Cell(1, 1, true),
      Cell(2, 1, true),
      Cell(3, 1),
      Cell(4, 1, true),
      Cell(1, 2, true),
      Cell(2, 2),
      Cell(3, 2),
      Cell(4, 2),
      Cell(1, 3),
      Cell(2, 3, true),
      Cell(3, 3),
      Cell(4, 3, true),
      Cell(1, 4),
      Cell(2, 4),
      Cell(3, 4, true),
      Cell(4, 4, true),
    ], solution: [
      Cell(3, 2),
      Cell(1, 4),
    ]),
    Level(id: 'x4c2n3', chapterId: '2', bestResult: 2, goodResult: 5, cells: [
      Cell(1, 1, true),
      Cell(2, 1),
      Cell(3, 1, true),
      Cell(4, 1, true),
      Cell(1, 2),
      Cell(2, 2),
      Cell(3, 2, true),
      Cell(4, 2, true),
      Cell(1, 3, true),
      Cell(2, 3, true),
      Cell(3, 3),
      Cell(4, 3),
      Cell(1, 4, true),
      Cell(2, 4, true),
      Cell(3, 4),
      Cell(4, 4, true),
    ], solution: [
      Cell(2, 2),
      Cell(3, 3),
    ]),
    Level(id: 'x4c2n4', chapterId: '2', bestResult: 2, goodResult: 5, cells: [
      Cell(1, 1, true),
      Cell(2, 1),
      Cell(3, 1),
      Cell(4, 1),
      Cell(1, 2, true),
      Cell(2, 2, true),
      Cell(3, 2),
      Cell(4, 2, true),
      Cell(1, 3, true),
      Cell(2, 3),
      Cell(3, 3, true),
      Cell(4, 3, true),
      Cell(1, 4),
      Cell(2, 4),
      Cell(3, 4),
      Cell(4, 4, true),
    ], solution: [
      Cell(3, 1),
      Cell(2, 4),
    ]),
    Level(id: 'x4c2n5', chapterId: '2', bestResult: 2, goodResult: 5, cells: [
      Cell(1, 1),
      Cell(2, 1, true),
      Cell(3, 1, true),
      Cell(4, 1, true),
      Cell(1, 2, true),
      Cell(2, 2),
      Cell(3, 2, true),
      Cell(4, 2, true),
      Cell(1, 3, true),
      Cell(2, 3),
      Cell(3, 3, true),
      Cell(4, 3, true),
      Cell(1, 4),
      Cell(2, 4, true),
      Cell(3, 4, true),
      Cell(4, 4, true),
    ], solution: [
      Cell(1, 2),
      Cell(1, 3),
    ]),
    Level(id: 'x4c2n6', chapterId: '2', bestResult: 2, goodResult: 5, cells: [
      Cell(1, 1, true),
      Cell(2, 1),
      Cell(3, 1),
      Cell(4, 1, true),
      Cell(1, 2),
      Cell(2, 2, true),
      Cell(3, 2, true),
      Cell(4, 2),
      Cell(1, 3, true),
      Cell(2, 3),
      Cell(3, 3),
      Cell(4, 3, true),
      Cell(1, 4, true),
      Cell(2, 4, true),
      Cell(3, 4, true),
      Cell(4, 4, true),
    ], solution: [
      Cell(2, 2),
      Cell(3, 2),
    ]),
    Level(id: 'x3c2n7', chapterId: '2', bestResult: 2, goodResult: 5, cells: [
      Cell(1, 1),
      Cell(2, 1),
      Cell(3, 1, true),
      Cell(1, 2),
      Cell(2, 2, true),
      Cell(3, 2),
      Cell(1, 3, true),
      Cell(2, 3),
      Cell(3, 3),
    ], solution: [
      Cell(3, 3),
      Cell(1, 1),
    ]),
    Level(id: 'x3c2n8', chapterId: '2', bestResult: 2, goodResult: 5, cells: [
      Cell(1, 1),
      Cell(2, 1),
      Cell(3, 1),
      Cell(1, 2),
      Cell(2, 2),
      Cell(3, 2, true),
      Cell(1, 3),
      Cell(2, 3),
      Cell(3, 3, true),
    ], solution: [
      Cell(1, 3),
      Cell(2, 1),
    ]),
    Level(id: 'x3c2n9', chapterId: '2', bestResult: 2, goodResult: 5, cells: [
      Cell(1, 1, true),
      Cell(2, 1, true),
      Cell(3, 1),
      Cell(1, 2),
      Cell(2, 2),
      Cell(3, 2, true),
      Cell(1, 3, true),
      Cell(2, 3),
      Cell(3, 3, true),
    ], solution: [
      Cell(2, 2),
      Cell(3, 1),
    ]),
    Level(id: 'x3c2n10', chapterId: '2', bestResult: 2, goodResult: 5, cells: [
      Cell(1, 1),
      Cell(2, 1, true),
      Cell(3, 1),
      Cell(1, 2),
      Cell(2, 2, true),
      Cell(3, 2),
      Cell(1, 3, true),
      Cell(2, 3),
      Cell(3, 3, true),
    ], solution: [
      Cell(2, 2),
      Cell(2, 1),
    ]),
    Level(id: 'x3c2n11', chapterId: '2', bestResult: 2, goodResult: 5, cells: [
      Cell(1, 1, true),
      Cell(2, 1, true),
      Cell(3, 1),
      Cell(1, 2),
      Cell(2, 2),
      Cell(3, 2, true),
      Cell(1, 3, true),
      Cell(2, 3, true),
      Cell(3, 3, true),
    ], solution: [
      Cell(1, 1),
      Cell(2, 1),
    ]),
    Level(id: 'x3c2n12', chapterId: '2', bestResult: 2, goodResult: 5, cells: [
      Cell(1, 1),
      Cell(2, 1, true),
      Cell(3, 1),
      Cell(1, 2),
      Cell(2, 2, true),
      Cell(3, 2),
      Cell(1, 3, true),
      Cell(2, 3, true),
      Cell(3, 3, true),
    ], solution: [
      Cell(3, 1),
      Cell(1, 1),
    ]),
    Level(id: 'x4c2n13', chapterId: '4', bestResult: 4, goodResult: 7, cells: [
      Cell(1, 1),
      Cell(2, 1),
      Cell(3, 1),
      Cell(4, 1),
      Cell(1, 2),
      Cell(2, 2, true),
      Cell(3, 2, true),
      Cell(4, 2),
      Cell(1, 3),
      Cell(2, 3, true),
      Cell(3, 3, true),
      Cell(4, 3),
      Cell(1, 4),
      Cell(2, 4),
      Cell(3, 4),
      Cell(4, 4),
    ], solution: [
      Cell(1, 1),
      Cell(4, 1),
      Cell(4, 4),
      Cell(1, 4),
    ]),
    // ------------------- CHAPTER 3 -------------------
    Level(id: 'x3s3n1', chapterId: '3', bestResult: 3, goodResult: 6, cells: [
      Cell(1, 1),
      Cell(2, 1, true),
      Cell(3, 1, true),
      Cell(1, 2, true),
      Cell(2, 2),
      Cell(3, 2, true),
      Cell(1, 3, true),
      Cell(2, 3, true),
      Cell(3, 3),
    ], solution: [
      Cell(1, 1),
      Cell(2, 2),
      Cell(3, 3),
    ]),
    Level(id: 'x3s4n1', chapterId: '4', bestResult: 4, goodResult: 7, cells: [
      Cell(1, 1, true),
      Cell(2, 1),
      Cell(3, 1, true),
      Cell(1, 2),
      Cell(2, 2, true),
      Cell(3, 2),
      Cell(1, 3, true),
      Cell(2, 3),
      Cell(3, 3, true),
    ], solution: [
      Cell(2, 1),
      Cell(3, 2),
      Cell(2, 3),
      Cell(1, 2),
    ]),
    Level(id: 'x3s4n2', chapterId: '4', bestResult: 4, goodResult: 7, cells: [
      Cell(1, 1),
      Cell(2, 1, true),
      Cell(3, 1, true),
      Cell(1, 2),
      Cell(2, 2),
      Cell(3, 2, true),
      Cell(1, 3),
      Cell(2, 3),
      Cell(3, 3),
    ], solution: [
      Cell(1, 1),
      Cell(1, 3),
      Cell(3, 3),
      Cell(2, 2),
    ]),

    Level(id: 'x4s4n4', chapterId: '4', bestResult: 4, goodResult: 7, cells: [
      Cell(1, 1),
      Cell(2, 1, true),
      Cell(3, 1, true),
      Cell(4, 1),
      Cell(1, 2, true),
      Cell(2, 2),
      Cell(3, 2),
      Cell(4, 2, true),
      Cell(1, 3, true),
      Cell(2, 3),
      Cell(3, 3),
      Cell(4, 3, true),
      Cell(1, 4),
      Cell(2, 4, true),
      Cell(3, 4, true),
      Cell(4, 4),
    ], solution: [
      Cell(2, 1),
      Cell(3, 4),
      Cell(3, 1),
      Cell(2, 4),
    ]),
    Level(id: 'x4s4n5', chapterId: '4', bestResult: 4, goodResult: 7, cells: [
      Cell(1, 1),
      Cell(2, 1, true),
      Cell(3, 1, true),
      Cell(4, 1, true),
      Cell(1, 2, true),
      Cell(2, 2, true),
      Cell(3, 2),
      Cell(4, 2, true),
      Cell(1, 3, true),
      Cell(2, 3, true),
      Cell(3, 3),
      Cell(4, 3, true),
      Cell(1, 4),
      Cell(2, 4, true),
      Cell(3, 4, true),
      Cell(4, 4, true),
    ], solution: [
      Cell(1, 1),
      Cell(1, 4),
      Cell(2, 2),
      Cell(2, 3),
    ]),
    Level(id: 'x4s4n6', chapterId: '4', bestResult: 4, goodResult: 7, cells: [
      Cell(1, 1),
      Cell(2, 1),
      Cell(3, 1),
      Cell(4, 1),
      Cell(1, 2, true),
      Cell(2, 2),
      Cell(3, 2),
      Cell(4, 2, true),
      Cell(1, 3),
      Cell(2, 3),
      Cell(3, 3),
      Cell(4, 3),
      Cell(1, 4, true),
      Cell(2, 4, true),
      Cell(3, 4, true),
      Cell(4, 4, true),
    ], solution: [
      Cell(2, 2),
      Cell(3, 2),
      Cell(1, 2),
      Cell(4, 2),
    ]),
    Level(id: 'x4s4n9', chapterId: '4', bestResult: 4, goodResult: 7, cells: [
      Cell(1, 1, true),
      Cell(2, 1, true),
      Cell(3, 1, true),
      Cell(4, 1),
      Cell(1, 2, true),
      Cell(2, 2, true),
      Cell(3, 2),
      Cell(4, 2, true),
      Cell(1, 3, true),
      Cell(2, 3),
      Cell(3, 3, true),
      Cell(4, 3, true),
      Cell(1, 4),
      Cell(2, 4, true),
      Cell(3, 4, true),
      Cell(4, 4, true),
    ], solution: [
      Cell(4, 1),
      Cell(3, 2),
      Cell(2, 3),
      Cell(1, 4),
    ]),
    Level(id: 'x4s4n10', chapterId: '4', bestResult: 4, goodResult: 7, cells: [
      Cell(1, 1, true),
      Cell(2, 1),
      Cell(3, 1, true),
      Cell(4, 1, true),
      Cell(1, 2),
      Cell(2, 2, true),
      Cell(3, 2),
      Cell(4, 2),
      Cell(1, 3, true),
      Cell(2, 3),
      Cell(3, 3, true),
      Cell(4, 3, true),
      Cell(1, 4, true),
      Cell(2, 4),
      Cell(3, 4, true),
      Cell(4, 4, true),
    ], solution: [
      Cell(3, 2),
      Cell(2, 3),
      Cell(1, 2),
      Cell(2, 1),
    ]),
    Level(id: 'x4s4n11', chapterId: '4', bestResult: 4, goodResult: 7, cells: [
      Cell(1, 1),
      Cell(2, 1),
      Cell(3, 1),
      Cell(4, 1),
      Cell(1, 2, true),
      Cell(2, 2, true),
      Cell(3, 2, true),
      Cell(4, 2, true),
      Cell(1, 3),
      Cell(2, 3),
      Cell(3, 3),
      Cell(4, 3),
      Cell(1, 4),
      Cell(2, 4, true),
      Cell(3, 4, true),
      Cell(4, 4),
    ], solution: [
      Cell(1, 3),
      Cell(1, 1),
      Cell(4, 3),
      Cell(4, 1),
    ]),

    Level(id: 'x4s4n12', chapterId: '4', bestResult: 4, goodResult: 7, cells: [
      Cell(1, 1),
      Cell(2, 1),
      Cell(3, 1, true),
      Cell(4, 1, true),
      Cell(1, 2, true),
      Cell(2, 2),
      Cell(3, 2),
      Cell(4, 2),
      Cell(1, 3),
      Cell(2, 3),
      Cell(3, 3),
      Cell(4, 3, true),
      Cell(1, 4, true),
      Cell(2, 4, true),
      Cell(3, 4),
      Cell(4, 4),
    ], solution: [
      Cell(3, 4),
      Cell(2, 3),
      Cell(3, 2),
      Cell(2, 1),
    ]),
    Level(id: 'x4s4n7', chapterId: '4', bestResult: 4, goodResult: 7, cells: [
      Cell(1, 1),
      Cell(2, 1),
      Cell(3, 1),
      Cell(4, 1),
      Cell(1, 2),
      Cell(2, 2),
      Cell(3, 2, true),
      Cell(4, 2),
      Cell(1, 3),
      Cell(2, 3),
      Cell(3, 3),
      Cell(4, 3),
      Cell(1, 4, true),
      Cell(2, 4),
      Cell(3, 4),
      Cell(4, 4),
    ], solution: [
      Cell(1, 1),
      Cell(2, 3),
      Cell(4, 1),
      Cell(4, 4),
    ]),
    Level(id: 'x4s4n8', chapterId: '4', bestResult: 4, goodResult: 7, cells: [
      Cell(1, 1, true),
      Cell(2, 1),
      Cell(3, 1),
      Cell(4, 1, true),
      Cell(1, 2),
      Cell(2, 2),
      Cell(3, 2),
      Cell(4, 2),
      Cell(1, 3),
      Cell(2, 3),
      Cell(3, 3),
      Cell(4, 3),
      Cell(1, 4, true),
      Cell(2, 4),
      Cell(3, 4),
      Cell(4, 4, true),
    ], solution: [
      Cell(2, 2),
      Cell(2, 3),
      Cell(3, 3),
      Cell(3, 2),
    ]),

    Level(id: 'x3s5n1', chapterId: '5', bestResult: 5, goodResult: 8, cells: [
      Cell(1, 1),
      Cell(2, 1),
      Cell(3, 1),
      Cell(1, 2),
      Cell(2, 2),
      Cell(3, 2),
      Cell(1, 3),
      Cell(2, 3),
      Cell(3, 3),
    ], solution: [
      Cell(1, 1),
      Cell(3, 1),
      Cell(3, 3),
      Cell(1, 3),
      Cell(2, 2),
    ]),
    Level(id: 'x3s5n2', chapterId: '5', bestResult: 5, goodResult: 8, cells: [
      Cell(1, 1, true),
      Cell(2, 1, true),
      Cell(3, 1, true),
      Cell(1, 2, true),
      Cell(2, 2),
      Cell(3, 2, true),
      Cell(1, 3, true),
      Cell(2, 3, true),
      Cell(3, 3, true),
    ], solution: [
      Cell(2, 1),
      Cell(3, 2),
      Cell(2, 3),
      Cell(1, 2),
      Cell(2, 2),
    ]),
    Level(id: 'x5s5n3', chapterId: '5', bestResult: 5, goodResult: 8, cells: [
      Cell(1, 1),
      Cell(2, 1, true),
      Cell(3, 1, true),
      Cell(4, 1, true),
      Cell(5, 1, true),
      Cell(1, 2, true),
      Cell(2, 2),
      Cell(3, 2, true),
      Cell(4, 2, true),
      Cell(5, 2, true),
      Cell(1, 3, true),
      Cell(2, 3, true),
      Cell(3, 3),
      Cell(4, 3, true),
      Cell(5, 3, true),
      Cell(1, 4, true),
      Cell(2, 4, true),
      Cell(3, 4, true),
      Cell(4, 4),
      Cell(5, 4, true),
      Cell(1, 5, true),
      Cell(2, 5, true),
      Cell(3, 5, true),
      Cell(4, 5, true),
      Cell(5, 5),
    ], solution: [
      Cell(1, 1),
      Cell(2, 2),
      Cell(3, 3),
      Cell(4, 4),
      Cell(5, 5),
    ]),
    Level(id: 'x5s5n4', chapterId: '5', bestResult: 5, goodResult: 8, cells: [
      Cell(1, 1, true),
      Cell(2, 1),
      Cell(3, 1),
      Cell(4, 1),
      Cell(5, 1),
      Cell(1, 2),
      Cell(2, 2, true),
      Cell(3, 2),
      Cell(4, 2),
      Cell(5, 2),
      Cell(1, 3),
      Cell(2, 3),
      Cell(3, 3, true),
      Cell(4, 3),
      Cell(5, 3),
      Cell(1, 4),
      Cell(2, 4),
      Cell(3, 4),
      Cell(4, 4),
      Cell(5, 4),
      Cell(1, 5),
      Cell(2, 5),
      Cell(3, 5),
      Cell(4, 5),
      Cell(5, 5, true),
    ], solution: [
      Cell(1, 3),
      Cell(2, 5),
      Cell(3, 1),
      Cell(5, 2),
      Cell(4, 4),
    ]),
    Level(id: 'x4s6n1', chapterId: '6', bestResult: 6, goodResult: 9, cells: [
      Cell(1, 1),
      Cell(2, 1, true),
      Cell(3, 1, true),
      Cell(4, 1),
      Cell(1, 2, true),
      Cell(2, 2, true),
      Cell(3, 2, true),
      Cell(4, 2, true),
      Cell(1, 3, true),
      Cell(2, 3, true),
      Cell(3, 3, true),
      Cell(4, 3, true),
      Cell(1, 4),
      Cell(2, 4, true),
      Cell(3, 4, true),
      Cell(4, 4),
    ], solution: [
      Cell(2, 1),
      Cell(3, 1),
      Cell(2, 3),
      Cell(3, 3),
      Cell(1, 4),
      Cell(4, 4),
    ]),

// Level(id: 'new 3x3', chapterId: 'edt 3x3', bestResult: 4, goodResult: 7, cells: [
//       Cell(1, 1),
//       Cell(2, 1),
//       Cell(3, 1),
//       Cell(1, 2),
//       Cell(2, 2),
//       Cell(3, 2),
//       Cell(1, 3),
//       Cell(2, 3),
//       Cell(3, 3),
//     ], solution: [
//       Cell(0, 0),
//       Cell(0, 0),
//       Cell(0, 0),
//       Cell(0, 0),
//     ]),

//     Level(id: 'new 4x4', chapterId: 'edt 4x4', bestResult: 4, goodResult: 7, cells: [
//       Cell(1, 1),
//       Cell(2, 1),
//       Cell(3, 1),
//       Cell(4, 1),
//       Cell(1, 2),
//       Cell(2, 2),
//       Cell(3, 2),
//       Cell(4, 2),
//       Cell(1, 3),
//       Cell(2, 3),
//       Cell(3, 3),
//       Cell(4, 3),
//       Cell(1, 4),
//       Cell(2, 4),
//       Cell(3, 4),
//       Cell(4, 4),
//     ], solution: [
//       Cell(0, 0),
//       Cell(0, 0),
//       Cell(0, 0),
//       Cell(0, 0),
//     ]),

    Level(
        id: 'x5s10n1',
        chapterId: '10',
        bestResult: 10,
        goodResult: 13,
        cells: [
          Cell(1, 1, true),
          Cell(2, 1),
          Cell(3, 1),
          Cell(4, 1),
          Cell(5, 1),
          Cell(1, 2),
          Cell(2, 2, true),
          Cell(3, 2),
          Cell(4, 2),
          Cell(5, 2),
          Cell(1, 3),
          Cell(2, 3),
          Cell(3, 3, true),
          Cell(4, 3),
          Cell(5, 3),
          Cell(1, 4),
          Cell(2, 4),
          Cell(3, 4),
          Cell(4, 4, true),
          Cell(5, 4),
          Cell(1, 5),
          Cell(2, 5),
          Cell(3, 5),
          Cell(4, 5),
          Cell(5, 5, true),
        ],
        solution: [
          Cell(1, 2),
          Cell(2, 1),
          Cell(2, 4),
          Cell(4, 2),
          Cell(2, 5),
          Cell(5, 2),
          Cell(3, 5),
          Cell(5, 3),
          Cell(3, 4),
          Cell(4, 3),
        ]),
  ];
}
