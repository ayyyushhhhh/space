import 'package:flutter/material.dart';

class MoodProvider with ChangeNotifier {
  String mood = "happy";
  bool canRequestFocus = true;
  void changeMood(String mood) {
    this.mood = mood;
    notifyListeners();
  }

  void changeFocus(bool focus) {
    canRequestFocus = focus;
    notifyListeners();
  }
}
