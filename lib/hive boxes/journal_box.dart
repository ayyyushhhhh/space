import 'dart:convert';

import 'package:hive/hive.dart';
import 'package:intl/intl.dart';
import 'package:space/models/journals/journal_model.dart';

class JournalHiveBox {
  static Future<void> init({required DateTime dateTime}) async {
    await Hive.openBox(DateFormat('d, MMMM, yyyy').format(dateTime));
  }

  static Box getBox({required DateTime dateTime}) {
    if (!Hive.isBoxOpen(DateFormat('d, MMMM, yyyy').format(dateTime))) {
      init(dateTime: dateTime);
    }
    return Hive.box(
      DateFormat('d, MMMM, yyyy').format(dateTime),
    );
  }

  static void closeBox({required DateTime dateTime}) {
    if (Hive.isBoxOpen(DateFormat('d, MMMM, yyyy').format(dateTime))) {
      getBox(dateTime: dateTime).close();
    }
  }

  static List<JournalModel> getListofJournals({required DateTime dateTime}) {
    List<JournalModel> journals = [];
    Box box = getBox(dateTime: dateTime);
    var keys = box.keys;
    for (var key in keys) {
      journals.add(JournalModel.fromMap(jsonDecode(
        jsonEncode(
          box.get(key),
        ),
      ) as Map<String, dynamic>));
    }
    return journals;
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
