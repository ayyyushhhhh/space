import 'package:flutter/material.dart';

class JournalEditorProvider with ChangeNotifier {
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
