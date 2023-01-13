import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:space/models/journals/journal_model.dart';
import 'package:space/provider/journal/journalProvider.dart';
import 'package:space/screens/journal/add_journal_screen.dart';

class JournalWidget extends StatelessWidget {
  final JournalModel journalModel;
  const JournalWidget({super.key, required this.journalModel});

  String _moodToEmoji({required String mood}) {
    switch (mood) {
      case "happy":
        {
          return "😀";
        }

      case "sad":
        {
          return "😞";
        }
      case "angry":
        {
          return "😤";
        }
      case "worried":
        {
          return "😨";
        }
      case "neutral":
        {
          return "😐";
        }
      default:
        {
          return "😀";
        }
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (BuildContext context) {
              return AddJournalScreen(
                journalModel: journalModel,
              );
            },
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.all(10),
        height: 70.h,
        width: double.infinity,
        decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(
              Radius.circular(10),
            ),
            color: Theme.of(context).cardColor),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              width: 30.w,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(10),
                  bottomLeft: Radius.circular(10),
                ),
                color: journalModel.color,
              ),
            ),
            SizedBox(
              width: 10.w,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  DateFormat.jm().format(journalModel.createdOn),
                  style:
                      TextStyle(fontSize: 10.sp, fontWeight: FontWeight.bold),
                ),
                Text(
                  DateFormat('d, MMMM, yyyy').format(journalModel.createdOn),
                  style:
                      TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold),
                ),
                Text(
                  "Mood : " "${_moodToEmoji(mood: journalModel.mood)}",
                  style:
                      TextStyle(fontSize: 10.sp, fontWeight: FontWeight.w500),
                )
              ],
            ),
            const Spacer(),
            IconButton(
              onPressed: () {
                Provider.of<JournalProvider>(context, listen: false)
                    .deleteJournal(journalModel: journalModel);
              },
              icon: const Icon(
                Icons.delete,
                color: Colors.grey,
              ),
            )
          ],
        ),
      ),
    );
  }
}
