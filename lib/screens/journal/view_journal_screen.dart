import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/cli_commands.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import 'package:space/models/journals/journal_model.dart';
import 'package:space/provider/journal/journal_editor_provider.dart';
import 'package:space/provider/journal/journal_provider.dart';
import 'package:space/utils/constants.dart';
import 'package:space/widgets/journal/journal_icon_button.dart';

class ViewJournalScreen extends StatefulWidget {
  final JournalModel journalModel;

  const ViewJournalScreen({super.key, required this.journalModel});

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
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
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
                              _saveJournal();
                              Navigator.pop(context);
                            },
                            iconData: CupertinoIcons.check_mark,
                          ),
                        ),
                      ],
                    ),
                    Text(
                      DateFormat('EEEE', context.locale.toString())
                          .format(journalModel.createdOn),
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 30.sp,
                          color: kPrimaryColor),
                    ).tr(),
                    Text(
                      DateFormat('d, MMMM, yyyy', context.locale.toString())
                          .format(journalModel.createdOn),
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 20.sp,
                      ),
                    ),
                  ],
                ),
              ),
              InkWell(
                onTap: () {
                  Provider.of<JournalEditorProvider>(context, listen: false)
                      .updateIndex(0);
                },
                child: Container(
                  height: 50.h,
                  width: double.infinity,
                  margin: const EdgeInsets.all(10),
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: kSecondaryColor),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                        "assets/emojis/${widget.journalModel.mood}.svg",
                        height: 35.h,
                        width: 35.w,
                      ),
                      Text(
                        widget.journalModel.mood.capitalize(),
                        style: TextStyle(fontSize: 16.sp),
                      ),
                      SizedBox(
                        width: 100.w,
                      ),
                      const Icon(CupertinoIcons.right_chevron)
                    ],
                  ),
                ),
              ),
              Semantics(
                label: 'Enter Title not more than 40 letters',
                hint: 'Press to enter journal title',
                child: Container(
                  width: double.infinity,
                  margin: const EdgeInsets.only(left: 10, right: 10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: TextField(
                    readOnly: true,
                    controller:
                        TextEditingController(text: widget.journalModel.title),
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.all(20),
                      fillColor: Theme.of(context).cardColor,
                      filled: true,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide.none,
                      ),
                      hintText: "Title",
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  width: double.infinity,
                  margin: const EdgeInsets.all(10),
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                  ),
                  child: TextField(
                    controller: TextEditingController(
                        text: widget.journalModel.description),
                    readOnly: true,
                    keyboardType: TextInputType.multiline,
                    textInputAction: TextInputAction.newline,
                    textAlignVertical: TextAlignVertical.top,
                    expands: true,
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.all(10),
                      fillColor: Theme.of(context).cardColor,
                      filled: true,
                      border: const OutlineInputBorder(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20),
                        ),
                        borderSide: BorderSide.none,
                      ),
                      hintText: "Notes",
                    ),
                    maxLines: null,
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
    Provider.of<JournalEditorProvider>(context, listen: false).index = 0;
    Provider.of<JournalProvider>(context, listen: false)
        .updateJournalList(journalModel);
  }
}
