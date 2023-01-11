import 'package:flutter/material.dart';
import 'package:space/hive%20boxes/journal_box.dart';
import 'package:space/models/journals/journal_model.dart';

class JournalProvider with ChangeNotifier {
  DateTime _dateTime = DateTime.now();
  bool _isRetrieving = false;
  bool get isRetrieving => _isRetrieving;

  DateTime get getDate => _dateTime;
  List<JournalModel> _listOfJournals = JournalHiveBox.getListofJournals(
    dateTime: DateTime.now(),
  );
  List<JournalModel> get journals => _listOfJournals;

  void updateDate(DateTime dateTime) async {
    _isRetrieving = true;
    await JournalHiveBox.init(dateTime: dateTime);
    notifyListeners();
    _isRetrieving = false;
    _dateTime = dateTime;
    _listOfJournals = JournalHiveBox.getListofJournals(
      dateTime: dateTime,
    );
    notifyListeners();
  }

  void updateJournalList(JournalModel journalModel) {
    _listOfJournals.add(journalModel);
    JournalHiveBox.saveJournal(dateTime: _dateTime, journalModel: journalModel);
    notifyListeners();
  }

  void deleteJournal({required JournalModel journalModel}) {
    JournalHiveBox.deleteJournal(
        dateTime: _dateTime, journalModel: journalModel);
    notifyListeners();
  }
}
