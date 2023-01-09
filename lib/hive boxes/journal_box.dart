import 'package:hive/hive.dart';
import 'package:intl/intl.dart';
import 'package:space/models/journals/journal_model.dart';

class JournalHiveBox {
  static Future<void> init({required DateTime dateTime}) async {
    await Hive.openBox(DateFormat('d, MMMM, yyyy').format(dateTime));
  }

  static Box getBox({required DateTime dateTime}) {
    return Hive.box(
      DateFormat('d, MMMM, yyyy').format(dateTime),
    );
  }

  static void saveJournal(
      {required DateTime dateTime, required JournalModel journalModel}) {
    if (!Hive.isBoxOpen(DateFormat('d, MMMM, yyyy').format(dateTime))) {
      init(dateTime: dateTime);
    }
    getBox(dateTime: dateTime)
        .put(journalModel.journalId, journalModel.toMap());
  }

  static void updateJournal(
      {required DateTime dateTime, required JournalModel journalModel}) {
    if (!Hive.isBoxOpen(DateFormat('d, MMMM, yyyy').format(dateTime))) {
      init(dateTime: dateTime);
    }
    getBox(dateTime: dateTime)
        .putAt(journalModel.journalId, journalModel.toMap());
  }

  static void deleteJournal(
      {required DateTime dateTime, required JournalModel journalModel}) {
    if (!Hive.isBoxOpen(DateFormat('d, MMMM, yyyy').format(dateTime))) {
      init(dateTime: dateTime);
    }
    getBox(dateTime: dateTime).delete(journalModel.journalId);
  }
}
