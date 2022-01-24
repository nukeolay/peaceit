import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserData with ChangeNotifier {
  late Map<String, CompletedLevel> completedLevels;
  late int _singleFlips;
  late int _solutionsNumber;

  static const int _initialSingleFlips = 2;
  static const int _initialsolutionsNumber = 50;

  UserData();

  // completedLevels methods
  int getLevelRatingById(String levelId) {
    return completedLevels[levelId]!.rating;
  }

  void setLevelRatingById({
    required String levelId,
    required int rating,
  }) {
    completedLevels[levelId]!.rating = rating;
  }

  bool isLevelCompleted(String levelId) {
    return completedLevels.keys.contains(levelId);
  }

  void setCompletedLevel(CompletedLevel completedLevel) {
    completedLevels[completedLevel.id] = completedLevel;
  }

  // singleFlips methods
  int get singleFlips => _singleFlips;

  void singleFlipsDecrement() {
    _singleFlips--;
    saveUserData();
  }

  void singleFlipsIncrement() {
    _singleFlips++;
    saveUserData();
  }

  // solutionsNumber methods
  int get solutionsNumber => _solutionsNumber;

  void solutionsNumberDecrement() {
    _solutionsNumber--;
    saveUserData();
  }

  void solutionsNumberIncrement() {
    _solutionsNumber++;
    saveUserData();
  }

  // user data persistance
  Future<void> loadUserData() async {
    // completedLevels = {};
    // _singleFlips = 1;
    final SharedPreferences _prefs = await SharedPreferences.getInstance();
    try {
      final tempUserData =
          UserData.fromJson(jsonDecode(_prefs.getString('userData')!));
      completedLevels = tempUserData.completedLevels;
      _singleFlips = tempUserData._singleFlips;
      _solutionsNumber = tempUserData._solutionsNumber;
    } catch (error) {
      completedLevels = {};
      _singleFlips = _initialSingleFlips;
      _solutionsNumber = _initialsolutionsNumber;
    }
  }

  Future<void> saveUserData() async {
    final SharedPreferences _prefs = await SharedPreferences.getInstance();
    await _prefs.setString('userData', jsonEncode(this));
  }

  Future<void> removeData() async {
    completedLevels = {};
    _singleFlips = _initialSingleFlips;
    _solutionsNumber = _initialsolutionsNumber;
    final SharedPreferences _prefs = await SharedPreferences.getInstance();
    await _prefs.clear();
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
  int moves;
  int rating;

  CompletedLevel({
    required this.id,
    required this.moves,
    required this.rating,
  });

  CompletedLevel.fromJson(Map<String, dynamic> json)
      : id = json['id'] as String,
        moves = json['moves'] as int,
        rating = json['rating'] as int;

  Map<String, dynamic> toJson() => {
        'id': id,
        'moves': moves,
        'rating': rating,
      };

  @override
  String toString() {
    return 'ID: $id, MOVES: $moves, RATING: $rating';
  }
}
