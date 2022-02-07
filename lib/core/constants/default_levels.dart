import 'package:darkit/features/levels/domain/entities/cell_entity.dart';
import 'package:darkit/features/levels/domain/entities/level_entity.dart';

class DefaultLevels {
  static final List<LevelEntity> levels = [ // TODO потом сделать не final, а const
    // ------------------- CHAPTER 1 -------------------
    LevelEntity(id: 'x3c1n1', chapterId: '1', bestResult: 1, goodResult: 4, cells: [
      CellEntity(1, 1, true),
      CellEntity(2, 1),
      CellEntity(3, 1, true),
      CellEntity(1, 2),
      CellEntity(2, 2),
      CellEntity(3, 2),
      CellEntity(1, 3, true),
      CellEntity(2, 3),
      CellEntity(3, 3, true),
    ], solution: [
      CellEntity(2, 2),
    ]),
    LevelEntity(id: 'x3c1n2', chapterId: '1', bestResult: 1, goodResult: 4, cells: [
      CellEntity(1, 1, true),
      CellEntity(2, 1, true),
      CellEntity(3, 1, true),
      CellEntity(1, 2),
      CellEntity(2, 2, true),
      CellEntity(3, 2, true),
      CellEntity(1, 3),
      CellEntity(2, 3),
      CellEntity(3, 3, true),
    ], solution: [
      CellEntity(1, 3),
    ]),
    LevelEntity(id: 'x3c1n3', chapterId: '1', bestResult: 1, goodResult: 4, cells: [
      CellEntity(1, 1, true),
      CellEntity(2, 1, true),
      CellEntity(3, 1, true),
      CellEntity(1, 2, true),
      CellEntity(2, 2),
      CellEntity(3, 2, true),
      CellEntity(1, 3),
      CellEntity(2, 3),
      CellEntity(3, 3),
    ], solution: [
      CellEntity(2, 3),
    ]),
    LevelEntity(id: 'x4c1n4', chapterId: '1', bestResult: 1, goodResult: 4, cells: [
      CellEntity(1, 1, true),
      CellEntity(2, 1),
      CellEntity(3, 1, true),
      CellEntity(4, 1, true),
      CellEntity(1, 2),
      CellEntity(2, 2),
      CellEntity(3, 2),
      CellEntity(4, 2, true),
      CellEntity(1, 3, true),
      CellEntity(2, 3),
      CellEntity(3, 3, true),
      CellEntity(4, 3, true),
      CellEntity(1, 4, true),
      CellEntity(2, 4, true),
      CellEntity(3, 4, true),
      CellEntity(4, 4, true),
    ], solution: [
      CellEntity(2, 2),
    ]),
    LevelEntity(id: 'x4c1n5', chapterId: '1', bestResult: 1, goodResult: 4, cells: [
      CellEntity(1, 1, true),
      CellEntity(2, 1, true),
      CellEntity(3, 1, true),
      CellEntity(4, 1, true),
      CellEntity(1, 2, true),
      CellEntity(2, 2, true),
      CellEntity(3, 2, true),
      CellEntity(4, 2, true),
      CellEntity(1, 3, true),
      CellEntity(2, 3),
      CellEntity(3, 3, true),
      CellEntity(4, 3, true),
      CellEntity(1, 4),
      CellEntity(2, 4),
      CellEntity(3, 4),
      CellEntity(4, 4, true),
    ], solution: [
      CellEntity(2, 4),
    ]),
    LevelEntity(id: 'x3c1n6', chapterId: '1', bestResult: 2, goodResult: 5, cells: [
      CellEntity(1, 1),
      CellEntity(2, 1),
      CellEntity(3, 1),
      CellEntity(1, 2, true),
      CellEntity(2, 2, true),
      CellEntity(3, 2, true),
      CellEntity(1, 3),
      CellEntity(2, 3),
      CellEntity(3, 3),
    ], solution: [
      CellEntity(2, 1),
      CellEntity(2, 3),
    ]),

    // ------------------- CHAPTER 2 -------------------

    LevelEntity(id: 'x4c2n1', chapterId: '2', bestResult: 2, goodResult: 5, cells: [
      CellEntity(1, 1),
      CellEntity(2, 1, true),
      CellEntity(3, 1, true),
      CellEntity(4, 1),
      CellEntity(1, 2),
      CellEntity(2, 2),
      CellEntity(3, 2),
      CellEntity(4, 2),
      CellEntity(1, 3),
      CellEntity(2, 3, true),
      CellEntity(3, 3, true),
      CellEntity(4, 3),
      CellEntity(1, 4, true),
      CellEntity(2, 4, true),
      CellEntity(3, 4, true),
      CellEntity(4, 4, true),
    ], solution: [
      CellEntity(1, 2),
      CellEntity(4, 2),
    ]),
    LevelEntity(id: 'x4c2n2', chapterId: '2', bestResult: 2, goodResult: 5, cells: [
      CellEntity(1, 1, true),
      CellEntity(2, 1, true),
      CellEntity(3, 1),
      CellEntity(4, 1, true),
      CellEntity(1, 2, true),
      CellEntity(2, 2),
      CellEntity(3, 2),
      CellEntity(4, 2),
      CellEntity(1, 3),
      CellEntity(2, 3, true),
      CellEntity(3, 3),
      CellEntity(4, 3, true),
      CellEntity(1, 4),
      CellEntity(2, 4),
      CellEntity(3, 4, true),
      CellEntity(4, 4, true),
    ], solution: [
      CellEntity(3, 2),
      CellEntity(1, 4),
    ]),
    LevelEntity(id: 'x4c2n3', chapterId: '2', bestResult: 2, goodResult: 5, cells: [
      CellEntity(1, 1, true),
      CellEntity(2, 1),
      CellEntity(3, 1, true),
      CellEntity(4, 1, true),
      CellEntity(1, 2),
      CellEntity(2, 2),
      CellEntity(3, 2, true),
      CellEntity(4, 2, true),
      CellEntity(1, 3, true),
      CellEntity(2, 3, true),
      CellEntity(3, 3),
      CellEntity(4, 3),
      CellEntity(1, 4, true),
      CellEntity(2, 4, true),
      CellEntity(3, 4),
      CellEntity(4, 4, true),
    ], solution: [
      CellEntity(2, 2),
      CellEntity(3, 3),
    ]),
    LevelEntity(id: 'x4c2n4', chapterId: '2', bestResult: 2, goodResult: 5, cells: [
      CellEntity(1, 1, true),
      CellEntity(2, 1),
      CellEntity(3, 1),
      CellEntity(4, 1),
      CellEntity(1, 2, true),
      CellEntity(2, 2, true),
      CellEntity(3, 2),
      CellEntity(4, 2, true),
      CellEntity(1, 3, true),
      CellEntity(2, 3),
      CellEntity(3, 3, true),
      CellEntity(4, 3, true),
      CellEntity(1, 4),
      CellEntity(2, 4),
      CellEntity(3, 4),
      CellEntity(4, 4, true),
    ], solution: [
      CellEntity(3, 1),
      CellEntity(2, 4),
    ]),
    LevelEntity(id: 'x4c2n5', chapterId: '2', bestResult: 2, goodResult: 5, cells: [
      CellEntity(1, 1),
      CellEntity(2, 1, true),
      CellEntity(3, 1, true),
      CellEntity(4, 1, true),
      CellEntity(1, 2, true),
      CellEntity(2, 2),
      CellEntity(3, 2, true),
      CellEntity(4, 2, true),
      CellEntity(1, 3, true),
      CellEntity(2, 3),
      CellEntity(3, 3, true),
      CellEntity(4, 3, true),
      CellEntity(1, 4),
      CellEntity(2, 4, true),
      CellEntity(3, 4, true),
      CellEntity(4, 4, true),
    ], solution: [
      CellEntity(1, 2),
      CellEntity(1, 3),
    ]),
    LevelEntity(id: 'x4c2n6', chapterId: '2', bestResult: 2, goodResult: 5, cells: [
      CellEntity(1, 1, true),
      CellEntity(2, 1),
      CellEntity(3, 1),
      CellEntity(4, 1, true),
      CellEntity(1, 2),
      CellEntity(2, 2, true),
      CellEntity(3, 2, true),
      CellEntity(4, 2),
      CellEntity(1, 3, true),
      CellEntity(2, 3),
      CellEntity(3, 3),
      CellEntity(4, 3, true),
      CellEntity(1, 4, true),
      CellEntity(2, 4, true),
      CellEntity(3, 4, true),
      CellEntity(4, 4, true),
    ], solution: [
      CellEntity(2, 2),
      CellEntity(3, 2),
    ]),
    LevelEntity(id: 'x3c2n7', chapterId: '2', bestResult: 2, goodResult: 5, cells: [
      CellEntity(1, 1),
      CellEntity(2, 1),
      CellEntity(3, 1, true),
      CellEntity(1, 2),
      CellEntity(2, 2, true),
      CellEntity(3, 2),
      CellEntity(1, 3, true),
      CellEntity(2, 3),
      CellEntity(3, 3),
    ], solution: [
      CellEntity(3, 3),
      CellEntity(1, 1),
    ]),
    LevelEntity(id: 'x3c2n8', chapterId: '2', bestResult: 2, goodResult: 5, cells: [
      CellEntity(1, 1),
      CellEntity(2, 1),
      CellEntity(3, 1),
      CellEntity(1, 2),
      CellEntity(2, 2),
      CellEntity(3, 2, true),
      CellEntity(1, 3),
      CellEntity(2, 3),
      CellEntity(3, 3, true),
    ], solution: [
      CellEntity(1, 3),
      CellEntity(2, 1),
    ]),
    LevelEntity(id: 'x3c2n9', chapterId: '2', bestResult: 2, goodResult: 5, cells: [
      CellEntity(1, 1, true),
      CellEntity(2, 1, true),
      CellEntity(3, 1),
      CellEntity(1, 2),
      CellEntity(2, 2),
      CellEntity(3, 2, true),
      CellEntity(1, 3, true),
      CellEntity(2, 3),
      CellEntity(3, 3, true),
    ], solution: [
      CellEntity(2, 2),
      CellEntity(3, 1),
    ]),
    LevelEntity(id: 'x3c2n10', chapterId: '2', bestResult: 2, goodResult: 5, cells: [
      CellEntity(1, 1),
      CellEntity(2, 1, true),
      CellEntity(3, 1),
      CellEntity(1, 2),
      CellEntity(2, 2, true),
      CellEntity(3, 2),
      CellEntity(1, 3, true),
      CellEntity(2, 3),
      CellEntity(3, 3, true),
    ], solution: [
      CellEntity(2, 2),
      CellEntity(2, 1),
    ]),
    LevelEntity(id: 'x3c2n11', chapterId: '2', bestResult: 2, goodResult: 5, cells: [
      CellEntity(1, 1, true),
      CellEntity(2, 1, true),
      CellEntity(3, 1),
      CellEntity(1, 2),
      CellEntity(2, 2),
      CellEntity(3, 2, true),
      CellEntity(1, 3, true),
      CellEntity(2, 3, true),
      CellEntity(3, 3, true),
    ], solution: [
      CellEntity(1, 1),
      CellEntity(2, 1),
    ]),
    LevelEntity(id: 'x3c2n12', chapterId: '2', bestResult: 2, goodResult: 5, cells: [
      CellEntity(1, 1),
      CellEntity(2, 1, true),
      CellEntity(3, 1),
      CellEntity(1, 2),
      CellEntity(2, 2, true),
      CellEntity(3, 2),
      CellEntity(1, 3, true),
      CellEntity(2, 3, true),
      CellEntity(3, 3, true),
    ], solution: [
      CellEntity(3, 1),
      CellEntity(1, 1),
    ]),
    LevelEntity(id: 'x3c2n13', chapterId: '2', bestResult: 2, goodResult: 5, cells: [
      CellEntity(1, 1),
      CellEntity(2, 1),
      CellEntity(3, 1, true),
      CellEntity(1, 2, true),
      CellEntity(2, 2, true),
      CellEntity(3, 2),
      CellEntity(1, 3, true),
      CellEntity(2, 3, true),
      CellEntity(3, 3),
    ], solution: [
      CellEntity(3, 2),
      CellEntity(2, 1),
    ]),
    LevelEntity(id: 'x4c2n14', chapterId: '2', bestResult: 4, goodResult: 7, cells: [
      CellEntity(1, 1),
      CellEntity(2, 1),
      CellEntity(3, 1),
      CellEntity(4, 1),
      CellEntity(1, 2),
      CellEntity(2, 2, true),
      CellEntity(3, 2, true),
      CellEntity(4, 2),
      CellEntity(1, 3),
      CellEntity(2, 3, true),
      CellEntity(3, 3, true),
      CellEntity(4, 3),
      CellEntity(1, 4),
      CellEntity(2, 4),
      CellEntity(3, 4),
      CellEntity(4, 4),
    ], solution: [
      CellEntity(1, 1),
      CellEntity(4, 1),
      CellEntity(4, 4),
      CellEntity(1, 4),
    ]),
    // ------------------- CHAPTER 3 -------------------
    LevelEntity(id: 'x3s3n1', chapterId: '3', bestResult: 3, goodResult: 6, cells: [
      CellEntity(1, 1),
      CellEntity(2, 1, true),
      CellEntity(3, 1, true),
      CellEntity(1, 2, true),
      CellEntity(2, 2),
      CellEntity(3, 2, true),
      CellEntity(1, 3, true),
      CellEntity(2, 3, true),
      CellEntity(3, 3),
    ], solution: [
      CellEntity(1, 1),
      CellEntity(2, 2),
      CellEntity(3, 3),
    ]),
    LevelEntity(id: 'x3s3n2', chapterId: '3', bestResult: 3, goodResult: 6, cells: [
      CellEntity(1, 1, true),
      CellEntity(2, 1, true),
      CellEntity(3, 1),
      CellEntity(1, 2, true),
      CellEntity(2, 2),
      CellEntity(3, 2, true),
      CellEntity(1, 3, true),
      CellEntity(2, 3, true),
      CellEntity(3, 3),
    ], solution: [
      CellEntity(1, 3),
      CellEntity(1, 1),
      CellEntity(2, 1),
    ]),
    LevelEntity(id: 'x3s3n3', chapterId: '3', bestResult: 3, goodResult: 6, cells: [
      CellEntity(1, 1, true),
      CellEntity(2, 1),
      CellEntity(3, 1),
      CellEntity(1, 2),
      CellEntity(2, 2, true),
      CellEntity(3, 2),
      CellEntity(1, 3),
      CellEntity(2, 3),
      CellEntity(3, 3),
    ], solution: [
      CellEntity(3, 3),
      CellEntity(1, 2),
      CellEntity(2, 1),
    ]),
    LevelEntity(id: 'x3s3n4', chapterId: '3', bestResult: 3, goodResult: 6, cells: [
      CellEntity(1, 1),
      CellEntity(2, 1, true),
      CellEntity(3, 1),
      CellEntity(1, 2, true),
      CellEntity(2, 2, true),
      CellEntity(3, 2),
      CellEntity(1, 3),
      CellEntity(2, 3, true),
      CellEntity(3, 3, true),
    ], solution: [
      CellEntity(1, 3),
      CellEntity(2, 2),
      CellEntity(2, 1),
    ]),
    LevelEntity(id: 'x3s3n5', chapterId: '3', bestResult: 3, goodResult: 6, cells: [
      CellEntity(1, 1, true),
      CellEntity(2, 1),
      CellEntity(3, 1),
      CellEntity(1, 2, true),
      CellEntity(2, 2, true),
      CellEntity(3, 2, true),
      CellEntity(1, 3, true),
      CellEntity(2, 3),
      CellEntity(3, 3, true),
    ], solution: [
      CellEntity(1, 3),
      CellEntity(1, 2),
      CellEntity(2, 1),
    ]),
    LevelEntity(id: 'x3s3n6', chapterId: '3', bestResult: 3, goodResult: 6, cells: [
      CellEntity(1, 1, true),
      CellEntity(2, 1),
      CellEntity(3, 1),
      CellEntity(1, 2, true),
      CellEntity(2, 2, true),
      CellEntity(3, 2),
      CellEntity(1, 3, true),
      CellEntity(2, 3),
      CellEntity(3, 3, true),
    ], solution: [
      CellEntity(1, 1),
      CellEntity(2, 2),
      CellEntity(2, 1),
    ]),
    LevelEntity(id: 'x3s3n7', chapterId: '3', bestResult: 3, goodResult: 6, cells: [
      CellEntity(1, 1, true),
      CellEntity(2, 1, true),
      CellEntity(3, 1),
      CellEntity(1, 2, true),
      CellEntity(2, 2),
      CellEntity(3, 2),
      CellEntity(1, 3),
      CellEntity(2, 3, true),
      CellEntity(3, 3, true),
    ], solution: [
      CellEntity(3, 1),
      CellEntity(1, 2),
      CellEntity(1, 1),
    ]),
    LevelEntity(id: 'x3s3n8', chapterId: '3', bestResult: 3, goodResult: 6, cells: [
      CellEntity(1, 1),
      CellEntity(2, 1),
      CellEntity(3, 1),
      CellEntity(1, 2),
      CellEntity(2, 2),
      CellEntity(3, 2),
      CellEntity(1, 3),
      CellEntity(2, 3, true),
      CellEntity(3, 3),
    ], solution: [
      CellEntity(3, 3),
      CellEntity(1, 3),
      CellEntity(2, 1),
    ]),
    LevelEntity(id: 'x3s3n9', chapterId: '3', bestResult: 3, goodResult: 6, cells: [
      CellEntity(1, 1),
      CellEntity(2, 1, true),
      CellEntity(3, 1),
      CellEntity(1, 2),
      CellEntity(2, 2),
      CellEntity(3, 2),
      CellEntity(1, 3, true),
      CellEntity(2, 3),
      CellEntity(3, 3, true),
    ], solution: [
      CellEntity(2, 3),
      CellEntity(3, 2),
      CellEntity(1, 2),
    ]),
    LevelEntity(id: 'x3s3n10', chapterId: '3', bestResult: 3, goodResult: 6, cells: [
      CellEntity(1, 1),
      CellEntity(2, 1),
      CellEntity(3, 1),
      CellEntity(1, 2, true),
      CellEntity(2, 2),
      CellEntity(3, 2, true),
      CellEntity(1, 3, true),
      CellEntity(2, 3),
      CellEntity(3, 3, true),
    ], solution: [
      CellEntity(2, 2),
      CellEntity(3, 1),
      CellEntity(1, 1),
    ]),
    LevelEntity(id: 'x3s3n11', chapterId: '3', bestResult: 3, goodResult: 6, cells: [
      CellEntity(1, 1),
      CellEntity(2, 1),
      CellEntity(3, 1),
      CellEntity(1, 2, true),
      CellEntity(2, 2),
      CellEntity(3, 2, true),
      CellEntity(1, 3),
      CellEntity(2, 3),
      CellEntity(3, 3),
    ], solution: [
      CellEntity(3, 2),
      CellEntity(2, 2),
      CellEntity(1, 2),
    ]),
    LevelEntity(id: 'x3s3n12', chapterId: '3', bestResult: 3, goodResult: 6, cells: [
      CellEntity(1, 1, true),
      CellEntity(2, 1, true),
      CellEntity(3, 1, true),
      CellEntity(1, 2),
      CellEntity(2, 2),
      CellEntity(3, 2),
      CellEntity(1, 3, true),
      CellEntity(2, 3),
      CellEntity(3, 3, true),
    ], solution: [
      CellEntity(3, 3),
      CellEntity(2, 3),
      CellEntity(1, 3),
    ]),
    LevelEntity(id: 'x4s3n13', chapterId: '3', bestResult: 3, goodResult: 6, cells: [
      CellEntity(1, 1, true),
      CellEntity(2, 1),
      CellEntity(3, 1, true),
      CellEntity(4, 1, true),
      CellEntity(1, 2),
      CellEntity(2, 2, true),
      CellEntity(3, 2),
      CellEntity(4, 2, true),
      CellEntity(1, 3),
      CellEntity(2, 3),
      CellEntity(3, 3),
      CellEntity(4, 3, true),
      CellEntity(1, 4),
      CellEntity(2, 4, true),
      CellEntity(3, 4),
      CellEntity(4, 4, true),
    ], solution: [
      CellEntity(2, 2),
      CellEntity(2, 3),
      CellEntity(2, 4),
    ]),
    LevelEntity(id: 'x4s3n14', chapterId: '3', bestResult: 3, goodResult: 6, cells: [
      CellEntity(1, 1),
      CellEntity(2, 1),
      CellEntity(3, 1, true),
      CellEntity(4, 1, true),
      CellEntity(1, 2),
      CellEntity(2, 2, true),
      CellEntity(3, 2),
      CellEntity(4, 2, true),
      CellEntity(1, 3, true),
      CellEntity(2, 3),
      CellEntity(3, 3),
      CellEntity(4, 3, true),
      CellEntity(1, 4, true),
      CellEntity(2, 4, true),
      CellEntity(3, 4, true),
      CellEntity(4, 4),
    ], solution: [
      CellEntity(3, 3),
      CellEntity(4, 4),
      CellEntity(1, 1),
    ]),
    LevelEntity(id: 'x4s3n15', chapterId: '3', bestResult: 3, goodResult: 6, cells: [
      CellEntity(1, 1),
      CellEntity(2, 1, true),
      CellEntity(3, 1, true),
      CellEntity(4, 1, true),
      CellEntity(1, 2, true),
      CellEntity(2, 2),
      CellEntity(3, 2, true),
      CellEntity(4, 2, true),
      CellEntity(1, 3, true),
      CellEntity(2, 3, true),
      CellEntity(3, 3),
      CellEntity(4, 3),
      CellEntity(1, 4, true),
      CellEntity(2, 4, true),
      CellEntity(3, 4),
      CellEntity(4, 4, true),
    ], solution: [
      CellEntity(3, 3),
      CellEntity(2, 2),
      CellEntity(1, 1),
    ]),
    LevelEntity(id: 'x4s3n16', chapterId: '3', bestResult: 3, goodResult: 6, cells: [
      CellEntity(1, 1),
      CellEntity(2, 1, true),
      CellEntity(3, 1),
      CellEntity(4, 1),
      CellEntity(1, 2),
      CellEntity(2, 2, true),
      CellEntity(3, 2),
      CellEntity(4, 2),
      CellEntity(1, 3, true),
      CellEntity(2, 3, true),
      CellEntity(3, 3),
      CellEntity(4, 3),
      CellEntity(1, 4, true),
      CellEntity(2, 4, true),
      CellEntity(3, 4, true),
      CellEntity(4, 4),
    ], solution: [
      CellEntity(4, 3),
      CellEntity(3, 1),
      CellEntity(1, 1),
    ]),
    LevelEntity(id: 'x4s3n17', chapterId: '3', bestResult: 3, goodResult: 6, cells: [
      CellEntity(1, 1),
      CellEntity(2, 1),
      CellEntity(3, 1),
      CellEntity(4, 1),
      CellEntity(1, 2),
      CellEntity(2, 2, true),
      CellEntity(3, 2, true),
      CellEntity(4, 2),
      CellEntity(1, 3, true),
      CellEntity(2, 3, true),
      CellEntity(3, 3, true),
      CellEntity(4, 3),
      CellEntity(1, 4, true),
      CellEntity(2, 4, true),
      CellEntity(3, 4),
      CellEntity(4, 4),
    ], solution: [
      CellEntity(1, 1),
      CellEntity(4, 1),
      CellEntity(4, 4),
    ]),
    LevelEntity(id: 'x4s3n18', chapterId: '3', bestResult: 3, goodResult: 6, cells: [
      CellEntity(1, 1, true),
      CellEntity(2, 1),
      CellEntity(3, 1),
      CellEntity(4, 1, true),
      CellEntity(1, 2),
      CellEntity(2, 2),
      CellEntity(3, 2, true),
      CellEntity(4, 2),
      CellEntity(1, 3),
      CellEntity(2, 3, true),
      CellEntity(3, 3, true),
      CellEntity(4, 3, true),
      CellEntity(1, 4, true),
      CellEntity(2, 4),
      CellEntity(3, 4, true),
      CellEntity(4, 4, true),
    ], solution: [
      CellEntity(2, 2),
      CellEntity(2, 3),
      CellEntity(3, 2),
    ]),
    LevelEntity(id: 'x4s4n8', chapterId: '3', bestResult: 4, goodResult: 7, cells: [
      CellEntity(1, 1, true),
      CellEntity(2, 1),
      CellEntity(3, 1),
      CellEntity(4, 1, true),
      CellEntity(1, 2),
      CellEntity(2, 2),
      CellEntity(3, 2),
      CellEntity(4, 2),
      CellEntity(1, 3),
      CellEntity(2, 3),
      CellEntity(3, 3),
      CellEntity(4, 3),
      CellEntity(1, 4, true),
      CellEntity(2, 4),
      CellEntity(3, 4),
      CellEntity(4, 4, true),
    ], solution: [
      CellEntity(2, 2),
      CellEntity(2, 3),
      CellEntity(3, 3),
      CellEntity(3, 2),
    ]),

    // ------------------- CHAPTER 4 -------------------

    LevelEntity(id: 'x3s4n1', chapterId: '4', bestResult: 4, goodResult: 7, cells: [
      CellEntity(1, 1, true),
      CellEntity(2, 1),
      CellEntity(3, 1, true),
      CellEntity(1, 2),
      CellEntity(2, 2, true),
      CellEntity(3, 2),
      CellEntity(1, 3, true),
      CellEntity(2, 3),
      CellEntity(3, 3, true),
    ], solution: [
      CellEntity(2, 1),
      CellEntity(3, 2),
      CellEntity(2, 3),
      CellEntity(1, 2),
    ]),
    LevelEntity(id: 'x3s4n2', chapterId: '4', bestResult: 4, goodResult: 7, cells: [
      CellEntity(1, 1),
      CellEntity(2, 1, true),
      CellEntity(3, 1, true),
      CellEntity(1, 2),
      CellEntity(2, 2),
      CellEntity(3, 2, true),
      CellEntity(1, 3),
      CellEntity(2, 3),
      CellEntity(3, 3),
    ], solution: [
      CellEntity(1, 1),
      CellEntity(1, 3),
      CellEntity(3, 3),
      CellEntity(2, 2),
    ]),

    LevelEntity(id: 'x4s4n3', chapterId: '4', bestResult: 4, goodResult: 7, cells: [
      CellEntity(1, 1),
      CellEntity(2, 1, true),
      CellEntity(3, 1, true),
      CellEntity(4, 1),
      CellEntity(1, 2, true),
      CellEntity(2, 2),
      CellEntity(3, 2),
      CellEntity(4, 2, true),
      CellEntity(1, 3, true),
      CellEntity(2, 3),
      CellEntity(3, 3),
      CellEntity(4, 3, true),
      CellEntity(1, 4),
      CellEntity(2, 4, true),
      CellEntity(3, 4, true),
      CellEntity(4, 4),
    ], solution: [
      CellEntity(2, 1),
      CellEntity(3, 4),
      CellEntity(3, 1),
      CellEntity(2, 4),
    ]),
    LevelEntity(id: 'x4s4n4', chapterId: '4', bestResult: 4, goodResult: 7, cells: [
      CellEntity(1, 1),
      CellEntity(2, 1, true),
      CellEntity(3, 1, true),
      CellEntity(4, 1, true),
      CellEntity(1, 2, true),
      CellEntity(2, 2, true),
      CellEntity(3, 2),
      CellEntity(4, 2, true),
      CellEntity(1, 3, true),
      CellEntity(2, 3, true),
      CellEntity(3, 3),
      CellEntity(4, 3, true),
      CellEntity(1, 4),
      CellEntity(2, 4, true),
      CellEntity(3, 4, true),
      CellEntity(4, 4, true),
    ], solution: [
      CellEntity(1, 1),
      CellEntity(1, 4),
      CellEntity(2, 2),
      CellEntity(2, 3),
    ]),
    LevelEntity(id: 'x4s4n5', chapterId: '4', bestResult: 4, goodResult: 7, cells: [
      CellEntity(1, 1),
      CellEntity(2, 1),
      CellEntity(3, 1),
      CellEntity(4, 1),
      CellEntity(1, 2, true),
      CellEntity(2, 2),
      CellEntity(3, 2),
      CellEntity(4, 2, true),
      CellEntity(1, 3),
      CellEntity(2, 3),
      CellEntity(3, 3),
      CellEntity(4, 3),
      CellEntity(1, 4, true),
      CellEntity(2, 4, true),
      CellEntity(3, 4, true),
      CellEntity(4, 4, true),
    ], solution: [
      CellEntity(2, 2),
      CellEntity(3, 2),
      CellEntity(1, 2),
      CellEntity(4, 2),
    ]),
    LevelEntity(id: 'x4s4n6', chapterId: '4', bestResult: 4, goodResult: 7, cells: [
      CellEntity(1, 1, true),
      CellEntity(2, 1, true),
      CellEntity(3, 1, true),
      CellEntity(4, 1),
      CellEntity(1, 2, true),
      CellEntity(2, 2, true),
      CellEntity(3, 2),
      CellEntity(4, 2, true),
      CellEntity(1, 3, true),
      CellEntity(2, 3),
      CellEntity(3, 3, true),
      CellEntity(4, 3, true),
      CellEntity(1, 4),
      CellEntity(2, 4, true),
      CellEntity(3, 4, true),
      CellEntity(4, 4, true),
    ], solution: [
      CellEntity(4, 1),
      CellEntity(3, 2),
      CellEntity(2, 3),
      CellEntity(1, 4),
    ]),
    LevelEntity(id: 'x4s4n7', chapterId: '4', bestResult: 4, goodResult: 7, cells: [
      CellEntity(1, 1, true),
      CellEntity(2, 1),
      CellEntity(3, 1, true),
      CellEntity(4, 1, true),
      CellEntity(1, 2),
      CellEntity(2, 2, true),
      CellEntity(3, 2),
      CellEntity(4, 2),
      CellEntity(1, 3, true),
      CellEntity(2, 3),
      CellEntity(3, 3, true),
      CellEntity(4, 3, true),
      CellEntity(1, 4, true),
      CellEntity(2, 4),
      CellEntity(3, 4, true),
      CellEntity(4, 4, true),
    ], solution: [
      CellEntity(3, 2),
      CellEntity(2, 3),
      CellEntity(1, 2),
      CellEntity(2, 1),
    ]),
    LevelEntity(id: 'x4s4n8', chapterId: '4', bestResult: 4, goodResult: 7, cells: [
      CellEntity(1, 1),
      CellEntity(2, 1),
      CellEntity(3, 1),
      CellEntity(4, 1),
      CellEntity(1, 2, true),
      CellEntity(2, 2, true),
      CellEntity(3, 2, true),
      CellEntity(4, 2, true),
      CellEntity(1, 3),
      CellEntity(2, 3),
      CellEntity(3, 3),
      CellEntity(4, 3),
      CellEntity(1, 4),
      CellEntity(2, 4, true),
      CellEntity(3, 4, true),
      CellEntity(4, 4),
    ], solution: [
      CellEntity(1, 3),
      CellEntity(1, 1),
      CellEntity(4, 3),
      CellEntity(4, 1),
    ]),

    LevelEntity(id: 'x4s4n9', chapterId: '4', bestResult: 4, goodResult: 7, cells: [
      CellEntity(1, 1),
      CellEntity(2, 1),
      CellEntity(3, 1, true),
      CellEntity(4, 1, true),
      CellEntity(1, 2, true),
      CellEntity(2, 2),
      CellEntity(3, 2),
      CellEntity(4, 2),
      CellEntity(1, 3),
      CellEntity(2, 3),
      CellEntity(3, 3),
      CellEntity(4, 3, true),
      CellEntity(1, 4, true),
      CellEntity(2, 4, true),
      CellEntity(3, 4),
      CellEntity(4, 4),
    ], solution: [
      CellEntity(3, 4),
      CellEntity(2, 3),
      CellEntity(3, 2),
      CellEntity(2, 1),
    ]),
    LevelEntity(id: 'x4s4n10', chapterId: '4', bestResult: 4, goodResult: 7, cells: [
      CellEntity(1, 1),
      CellEntity(2, 1),
      CellEntity(3, 1),
      CellEntity(4, 1),
      CellEntity(1, 2),
      CellEntity(2, 2),
      CellEntity(3, 2, true),
      CellEntity(4, 2),
      CellEntity(1, 3),
      CellEntity(2, 3),
      CellEntity(3, 3),
      CellEntity(4, 3),
      CellEntity(1, 4, true),
      CellEntity(2, 4),
      CellEntity(3, 4),
      CellEntity(4, 4),
    ], solution: [
      CellEntity(1, 1),
      CellEntity(2, 3),
      CellEntity(4, 1),
      CellEntity(4, 4),
    ]),

    LevelEntity(id: 'x3s5n1', chapterId: '5', bestResult: 5, goodResult: 8, cells: [
      CellEntity(1, 1),
      CellEntity(2, 1),
      CellEntity(3, 1),
      CellEntity(1, 2),
      CellEntity(2, 2),
      CellEntity(3, 2),
      CellEntity(1, 3),
      CellEntity(2, 3),
      CellEntity(3, 3),
    ], solution: [
      CellEntity(1, 1),
      CellEntity(3, 1),
      CellEntity(3, 3),
      CellEntity(1, 3),
      CellEntity(2, 2),
    ]),
    LevelEntity(id: 'x3s5n2', chapterId: '5', bestResult: 5, goodResult: 8, cells: [
      CellEntity(1, 1, true),
      CellEntity(2, 1, true),
      CellEntity(3, 1, true),
      CellEntity(1, 2, true),
      CellEntity(2, 2),
      CellEntity(3, 2, true),
      CellEntity(1, 3, true),
      CellEntity(2, 3, true),
      CellEntity(3, 3, true),
    ], solution: [
      CellEntity(2, 1),
      CellEntity(3, 2),
      CellEntity(2, 3),
      CellEntity(1, 2),
      CellEntity(2, 2),
    ]),
    LevelEntity(id: 'x5s5n3', chapterId: '5', bestResult: 5, goodResult: 8, cells: [
      CellEntity(1, 1),
      CellEntity(2, 1, true),
      CellEntity(3, 1, true),
      CellEntity(4, 1, true),
      CellEntity(5, 1, true),
      CellEntity(1, 2, true),
      CellEntity(2, 2),
      CellEntity(3, 2, true),
      CellEntity(4, 2, true),
      CellEntity(5, 2, true),
      CellEntity(1, 3, true),
      CellEntity(2, 3, true),
      CellEntity(3, 3),
      CellEntity(4, 3, true),
      CellEntity(5, 3, true),
      CellEntity(1, 4, true),
      CellEntity(2, 4, true),
      CellEntity(3, 4, true),
      CellEntity(4, 4),
      CellEntity(5, 4, true),
      CellEntity(1, 5, true),
      CellEntity(2, 5, true),
      CellEntity(3, 5, true),
      CellEntity(4, 5, true),
      CellEntity(5, 5),
    ], solution: [
      CellEntity(1, 1),
      CellEntity(2, 2),
      CellEntity(3, 3),
      CellEntity(4, 4),
      CellEntity(5, 5),
    ]),
    LevelEntity(id: 'x5s5n4', chapterId: '5', bestResult: 5, goodResult: 8, cells: [
      CellEntity(1, 1, true),
      CellEntity(2, 1),
      CellEntity(3, 1),
      CellEntity(4, 1),
      CellEntity(5, 1),
      CellEntity(1, 2),
      CellEntity(2, 2, true),
      CellEntity(3, 2),
      CellEntity(4, 2),
      CellEntity(5, 2),
      CellEntity(1, 3),
      CellEntity(2, 3),
      CellEntity(3, 3, true),
      CellEntity(4, 3),
      CellEntity(5, 3),
      CellEntity(1, 4),
      CellEntity(2, 4),
      CellEntity(3, 4),
      CellEntity(4, 4),
      CellEntity(5, 4),
      CellEntity(1, 5),
      CellEntity(2, 5),
      CellEntity(3, 5),
      CellEntity(4, 5),
      CellEntity(5, 5, true),
    ], solution: [
      CellEntity(1, 3),
      CellEntity(2, 5),
      CellEntity(3, 1),
      CellEntity(5, 2),
      CellEntity(4, 4),
    ]),
    LevelEntity(id: 'x4s6n1', chapterId: '6', bestResult: 6, goodResult: 9, cells: [
      CellEntity(1, 1),
      CellEntity(2, 1, true),
      CellEntity(3, 1, true),
      CellEntity(4, 1),
      CellEntity(1, 2, true),
      CellEntity(2, 2, true),
      CellEntity(3, 2, true),
      CellEntity(4, 2, true),
      CellEntity(1, 3, true),
      CellEntity(2, 3, true),
      CellEntity(3, 3, true),
      CellEntity(4, 3, true),
      CellEntity(1, 4),
      CellEntity(2, 4, true),
      CellEntity(3, 4, true),
      CellEntity(4, 4),
    ], solution: [
      CellEntity(2, 1),
      CellEntity(3, 1),
      CellEntity(2, 3),
      CellEntity(3, 3),
      CellEntity(1, 4),
      CellEntity(4, 4),
    ]),

// LevelEntity(id: 'new 3x3', chapterId: 'edt 3x3', bestResult: 4, goodResult: 7, cells: [
//       CellEntity(1, 1),
//       CellEntity(2, 1),
//       CellEntity(3, 1),
//       CellEntity(1, 2),
//       CellEntity(2, 2),
//       CellEntity(3, 2),
//       CellEntity(1, 3),
//       CellEntity(2, 3),
//       CellEntity(3, 3),
//     ], solution: [
//       CellEntity(0, 0),
//       CellEntity(0, 0),
//       CellEntity(0, 0),
//       CellEntity(0, 0),
//     ]),

//     LevelEntity(id: 'new 4x4', chapterId: 'edt 4x4', bestResult: 4, goodResult: 7, cells: [
//       CellEntity(1, 1),
//       CellEntity(2, 1),
//       CellEntity(3, 1),
//       CellEntity(4, 1),
//       CellEntity(1, 2),
//       CellEntity(2, 2),
//       CellEntity(3, 2),
//       CellEntity(4, 2),
//       CellEntity(1, 3),
//       CellEntity(2, 3),
//       CellEntity(3, 3),
//       CellEntity(4, 3),
//       CellEntity(1, 4),
//       CellEntity(2, 4),
//       CellEntity(3, 4),
//       CellEntity(4, 4),
//     ], solution: [
//       CellEntity(0, 0),
//       CellEntity(0, 0),
//       CellEntity(0, 0),
//       CellEntity(0, 0),
//     ]),

    LevelEntity(
        id: 'x5s10n1',
        chapterId: '10',
        bestResult: 10,
        goodResult: 13,
        cells: [
          CellEntity(1, 1, true),
          CellEntity(2, 1),
          CellEntity(3, 1),
          CellEntity(4, 1),
          CellEntity(5, 1),
          CellEntity(1, 2),
          CellEntity(2, 2, true),
          CellEntity(3, 2),
          CellEntity(4, 2),
          CellEntity(5, 2),
          CellEntity(1, 3),
          CellEntity(2, 3),
          CellEntity(3, 3, true),
          CellEntity(4, 3),
          CellEntity(5, 3),
          CellEntity(1, 4),
          CellEntity(2, 4),
          CellEntity(3, 4),
          CellEntity(4, 4, true),
          CellEntity(5, 4),
          CellEntity(1, 5),
          CellEntity(2, 5),
          CellEntity(3, 5),
          CellEntity(4, 5),
          CellEntity(5, 5, true),
        ],
        solution: [
          CellEntity(1, 2),
          CellEntity(2, 1),
          CellEntity(2, 4),
          CellEntity(4, 2),
          CellEntity(2, 5),
          CellEntity(5, 2),
          CellEntity(3, 5),
          CellEntity(5, 3),
          CellEntity(3, 4),
          CellEntity(4, 3),
        ]),
  ];
}
