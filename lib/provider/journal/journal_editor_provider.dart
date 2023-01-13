import 'package:flutter/material.dart';

class JournalEditorProvider with ChangeNotifier {
  String mood = "happy";
  bool readOnly = false;
  void changeMood(String mood) {
    this.mood = mood;
    notifyListeners();
  }

  void canReadOnly(bool read) {
    readOnly = read;
    notifyListeners();
  }
}
