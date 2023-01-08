import 'package:flutter/material.dart';

class MoodProvider with ChangeNotifier {
  String mood = "happy";
  void changeMood(String mood) {
    this.mood = mood;
    notifyListeners();
  }
}
