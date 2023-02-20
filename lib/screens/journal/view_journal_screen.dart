import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import 'package:space/models/journals/journal_model.dart';
import 'package:space/provider/journal/journal_editor_provider.dart';
import 'package:space/provider/journal/journal_provider.dart';
import 'package:space/utils/constants.dart';
import 'package:space/utils/utils_functions.dart';
import 'package:space/widgets/journal/journal_icon_button.dart';

class ViewJournalScreen extends StatefulWidget {
  final JournalModel journalModel;
  final bool readOnly;

  const ViewJournalScreen(
      {super.key, required this.journalModel, required this.readOnly});

  @override
  State<ViewJournalScreen> createState() => _ViewJournalScreenState();
}

class _ViewJournalScreenState extends State<ViewJournalScreen> {
  late JournalModel journalModel;

  @override
  void initState() {
    super.initState();
    journalModel = widget.journalModel;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          color: Theme.of(context).scaffoldBackgroundColor,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                color: Theme.of(context).scaffoldBackgroundColor,
                padding: const EdgeInsets.only(
                    left: 20, right: 20, top: 10, bottom: 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        if (widget.readOnly)
                          JournalIconButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              iconData: Icons.close),
                        const Spacer(),
                        SizedBox(
                          width: 10.w,
                        ),
                        // Semantics(
                        //   label: 'Edit Journal',
                        //   hint: 'Press to edit journal',
                        //   child: Consumer<JournalEditorProvider>(
                        //     builder:
                        //         (BuildContext context, value, Widget? child) {
                        //       if (value.readOnly == true) {
                        //         return JournalIconButton(
                        //           onPressed: () {
                        //             value.canReadOnly(false);
                        //           },
                        //           iconData: CupertinoIcons.pen,
                        //         );
                        //       }
                        //       return const SizedBox();
                        //     },
                        //   ),
                        // ),
                        Semantics(
                          label: 'Save Journal',
                          hint: 'Press to save journal',
                          child: JournalIconButton(
                            onPressed: () {
                              if (!widget.readOnly) {
                                _saveJournal();
                              }

                              Navigator.pop(context);
                            },
                            iconData: CupertinoIcons.check_mark,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    Text(
                      DateFormat('EEEE', context.locale.toString())
                          .format(journalModel.createdOn),
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 28.sp,
                          color: kPrimaryColor),
                    ).tr(),
                    Text(
                      DateFormat('d, MMMM, yyyy', context.locale.toString())
                          .format(journalModel.createdOn),
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 18.sp,
                      ),
                    ),
                  ],
                ),
              ),
              InkWell(
                onTap: () {
                  if (widget.readOnly == false) {
                    Provider.of<JournalEditorProvider>(context, listen: false)
                        .updateIndex(0);
                  }
                },
                child: Container(
                  height: 60.h,
                  width: double.infinity,
                  margin: const EdgeInsets.only(
                      left: 20, right: 20, top: 10, bottom: 10),
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: getTextFieldColorbyTheme(context)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 10.w,
                      ),
                      SvgPicture.asset(
                        "assets/emojis/${journalModel.mood}.svg",
                        height: 35.h,
                        width: 35.w,
                      ),
                      SizedBox(
                        width: 20.w,
                      ),
                      Text(
                        journalModel.mood.toTitleCase(),
                        style: TextStyle(
                          fontSize: 16.sp,
                          color: getTextColorbyTheme(context),
                        ),
                      ),
                      const Expanded(
                        child: SizedBox(),
                      ),
                      Icon(
                        CupertinoIcons.right_chevron,
                        color: getTextColorbyTheme(context),
                      )
                    ],
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  if (widget.readOnly == false) {
                    Provider.of<JournalEditorProvider>(context, listen: false)
                        .updateIndex(1);
                  }
                },
                child: Container(
                  width: double.infinity,
                  height: 60.h,
                  padding: const EdgeInsets.all(10),
                  margin: const EdgeInsets.only(
                      left: 20, right: 20, top: 10, bottom: 10),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: getTextFieldColorbyTheme(context)),
                  child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        widget.journalModel.title,
                        style: TextStyle(color: getTextColorbyTheme(context)),
                      )),
                ),
              ),
              Expanded(
                flex: 1,
                child: InkWell(
                  onTap: () {
                    if (widget.readOnly == false) {
                      Provider.of<JournalEditorProvider>(context, listen: false)
                          .updateIndex(2);
                    }
                  },
                  child: Container(
                    width: double.infinity,
                    margin: const EdgeInsets.only(
                        left: 20, right: 20, top: 10, bottom: 20),
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10)),
                        color: getTextFieldColorbyTheme(context)),
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: SingleChildScrollView(
                        scrollDirection: Axis.vertical,
                        child: Text(
                          journalModel.description,
                          style: TextStyle(color: getTextColorbyTheme(context)),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _saveJournal() {
    Provider.of<JournalEditorProvider>(context, listen: false).updateIndex(0);
    Provider.of<JournalProvider>(context, listen: false)
        .updateJournalList(journalModel);
  }
}
