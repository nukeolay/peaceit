import 'package:flutter/cupertino.dart';

class UserData with ChangeNotifier {
  late Map<String, CompletedLevel>
      completedLevels; // TODO в ключе хранить id уровня
  late int singleFlips;
  bool _isinit = true;

  UserData() {
    if (_isinit) {
      loadUserData();
      _isinit = false;
    }
  }

  Future<void> loadUserData() async {
    // TODO await грузим из sharedPreferences
    // если не загрузился, singleFlips = 3, copmletedLevel = {}
    completedLevels = {
      '3x3a': CompletedLevel(
        id: '3x3a',
        moves: 1,
        rating: 3,
      ),
      '3x3b': CompletedLevel(
        id: '3x3a',
        moves: 5,
        rating: 1,
      )
    };
    singleFlips = 9;
  }

  Future<void> saveUserData() async {
    //TODO await сохраняем в sharedPreferences
  }
}

class CompletedLevel {
  String id;
  int moves;
  int rating;

  CompletedLevel({
    required this.id,
    required this.moves,
    required this.rating,
  });
}
