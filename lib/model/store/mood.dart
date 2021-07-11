import 'package:mood/model/database/mood/mood.dart';
import 'package:flutter/material.dart';
import '../../utility.dart';

class MoodBLoC with ChangeNotifier {
  Mood _mood = Mood();
  Mood _todaysMood = new Mood();
  List<Mood> _allMoods;

  // Get the mood object
  Mood get mood => _mood;
  Mood get todaysMood => _todaysMood;
  List<Mood> get allMoods => _allMoods;

  setMood(Mood mood) {
    _mood = Mood(
        mood: mood.mood,
        mdate: mood.mdate,
        feelingDescription: mood.feelingDescription);
    _updateAllMoods();
    notifyListeners();
  }

  setAllMoods(List<Mood> moods) {
    _allMoods = moods;
    notifyListeners();
  }

  setTodaysMood(Mood todaysMood) {
    _todaysMood = todaysMood;

    notifyListeners();
  }

  _updateAllMoods() {
    bool dateExists = false;
    for (int i = 0; i < _allMoods.length; i++) {
      if (Utility.formatter.format(_allMoods[i].mdate) ==
          Utility.formatter.format(_mood.mdate)) {
        dateExists = true;
        _allMoods[i] = _mood;
      }
    }

    // If the date doesnt already exist in the list add it
    // Cann occur for todays date if its first entry
    if (!dateExists) {
      _allMoods.add(_mood);
    }
  }
}
