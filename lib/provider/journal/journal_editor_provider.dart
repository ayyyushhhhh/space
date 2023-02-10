import 'package:flutter/material.dart';

class JournalEditorProvider with ChangeNotifier {
  String mood = "happy";
  int index = 0;
  bool readOnly = false;

  void changeMood(String mood) {
    this.mood = mood;
    notifyListeners();
  }

  void updateIndex(int index) {
    this.index = index;
    notifyListeners();
  }

  void canReadOnly(bool read) {
    readOnly = read;
    notifyListeners();
  }
}
