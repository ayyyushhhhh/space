import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:space/models/journals/journal_model.dart';
import 'package:space/provider/journal/journal_provider.dart';
import 'package:space/screens/Journals/View%20Journal%20Screen/view_journal_screen.dart';
import 'package:space/utils/ui_colors.dart';
import 'package:space/utils/utils_functions.dart';

class JournalWidget extends StatelessWidget {
  final JournalModel journalModel;
  const JournalWidget({super.key, required this.journalModel});
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (BuildContext context) {
              return ViewJournalScreen(
                journalModel: journalModel,
                readOnly: true,
              );
            },
          ),
        ).then((value) {
          SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
              statusBarColor:
                  kSecondaryColor //or set color with: Color(0xFF0000FF)
              ));
        });
      },
      child: Slidable(
        endActionPane: ActionPane(
          extentRatio: 0.25.r,
          motion: const ScrollMotion(),
          children: [
            CustomSlidableAction(
              onPressed: (BuildContext context) {
                Provider.of<JournalProvider>(context, listen: false)
                    .deleteJournal(journalModel: journalModel);
              },
              backgroundColor: Colors.transparent,
              child: Semantics(
                label: 'delete journal',
                hint: 'Press  to delete journal',
                child: Container(
                  height: 50.h,
                  width: 100.w,
                  padding: const EdgeInsets.all(10),
                  margin: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.red),
                  child: const Icon(CupertinoIcons.delete),
                ),
              ),
            ),
          ],
        ),
        child: Container(
          margin:
              const EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
          height: 120.h,
          width: double.infinity,
          decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(
                Radius.circular(20),
              ),
              color: Theme.of(context).cardColor),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: 20.w,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(20),
                    bottomLeft: Radius.circular(20),
                  ),
                  color: journalModel.color,
                ),
              ),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            DateFormat.jm().format(journalModel.createdOn),
                            style: TextStyle(
                                fontSize: 10.sp, fontWeight: FontWeight.w400),
                          ),
                          SizedBox(
                            width: 10.w,
                          ),
                          Container(
                            padding: const EdgeInsets.all(5),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(40),
                                color: journalModel.color),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  journalModel.mood.toTitleCase(),
                                  style: TextStyle(
                                      fontSize: 10.sp,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.white),
                                ),
                                SvgPicture.asset(
                                  "assets/emojis/${journalModel.mood}.svg",
                                  height: 20.h,
                                  width: 20.w,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      Text(
                        journalModel.title,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w500,
                            color: getTextColorbyTheme(context)),
                      ),
                      SizedBox(
                        height: 40,
                        child: Text(
                          journalModel.description,
                          maxLines: 2,
                          softWrap: true,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              fontSize: 10.sp,
                              fontWeight: FontWeight.w400,
                              color: getTextColorbyTheme(context)),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
