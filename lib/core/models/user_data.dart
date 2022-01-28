import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:makeitdark/core/constants/initial_game_settings.dart';
import 'package:makeitdark/core/models/game.dart';
import 'package:makeitdark/core/models/level.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserData with ChangeNotifier {
  late Map<String, CompletedLevel> completedLevels;
  late int _singleFlips;
  late int _solutionsNumber;

  UserData();

  // completedLevels methods

  bool isLevelCompleted(String levelId) {
    return completedLevels.keys.contains(levelId);
  }

  void setCompletedLevel(CompletedLevel completedLevel) {
    completedLevels[completedLevel.id] = completedLevel;
  }

  // help methods
  int get singleFlips => _singleFlips;

  int get solutionsNumber => _solutionsNumber;

  // user data persistance
  Future<void> loadUserData() async {
    final SharedPreferences _prefs = await SharedPreferences.getInstance();
    try {
      final tempUserData =
          UserData.fromJson(jsonDecode(_prefs.getString('userData')!));
      completedLevels = tempUserData.completedLevels;
      _singleFlips = tempUserData._singleFlips;
      _solutionsNumber = tempUserData._solutionsNumber;
    } catch (error) {
      completedLevels = {};
      _singleFlips = InitialGameSettings.singleFlips;
      _solutionsNumber = InitialGameSettings.solutionsNumber;
    }
  }

  Future<void> saveUserData(Game game) async {
    final SharedPreferences _prefs = await SharedPreferences.getInstance();
    _singleFlips = game.singleFlips;
    _solutionsNumber = game.solutionsNumber;
    List<Level> _levels = game.allLevels;
    for (Level level in _levels) {
      completedLevels[level.id] =
          CompletedLevel(id: level.id, rating: level.rating);
    }
    await _prefs.setString('userData', jsonEncode(this));
  }

  UserData.fromJson(Map<String, dynamic> json)
      : completedLevels = (json['completedLevels'] as Map<String, dynamic>)
            .map((id, value) => MapEntry(id, CompletedLevel.fromJson(value))),
        _singleFlips = json['singleFlips'] as int,
        _solutionsNumber = json['solutionsNumber'] as int;

  Map<String, dynamic> toJson() => {
        'completedLevels': completedLevels,
        'singleFlips': _singleFlips,
        'solutionsNumber': _solutionsNumber,
      };
}

class CompletedLevel {
  String id;
  int rating;

  CompletedLevel({
    required this.id,
    required this.rating,
  });

  CompletedLevel.fromJson(Map<String, dynamic> json)
      : id = json['id'] as String,
        rating = json['rating'] as int;

  Map<String, dynamic> toJson() => {
        'id': id,
        'rating': rating,
      };

  @override
  String toString() {
    return 'ID: $id, RATING: $rating';
  }
}
