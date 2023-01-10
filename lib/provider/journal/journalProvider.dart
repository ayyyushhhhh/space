import 'package:flutter/material.dart';
import 'package:space/models/journals/journal_model.dart';

class JournalProvider with ChangeNotifier {
  DateTime _dateTime = DateTime.now();
  bool isSaving = false;

  DateTime get getDate => _dateTime;
  List<JournalModel> listOfJournals = [];
  List<JournalModel> get journals => listOfJournals;

  void updateDate(DateTime dateTime) async {
    _dateTime = dateTime;
    notifyListeners();
  }
}
