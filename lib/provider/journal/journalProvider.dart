import 'package:space/models/journals/journal_model.dart';
import 'package:flutter/foundation.dart';

class JournalProvider with ChangeNotifier {
  final List<JournalModel> _journals = [];

  List<JournalModel> get journalsList => _journals;

  void addJournal(JournalModel journal) {
    _journals.add(journal);
    notifyListeners();
  }
}
