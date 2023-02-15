import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:space/models/journals/journal_model.dart';
import 'package:space/provider/journal/journal_editor_provider.dart';
import 'package:space/screens/journal/view_journal_screen.dart';
import 'package:space/utils/constants.dart';
import 'package:space/widgets/helper/blur.dart';
import 'package:space/widgets/journal/mood_select_widget.dart';
import 'package:space/widgets/journal/note_text_field_widget.dart';
import 'package:space/widgets/journal/title_text_field_widget.dart';

class AddJournalPageWidget extends StatefulWidget {
  const AddJournalPageWidget({super.key});

  @override
  State<AddJournalPageWidget> createState() => _AddJournalPageWidgetState();
}

class _AddJournalPageWidgetState extends State<AddJournalPageWidget> {
  TextEditingController titleEditingController = TextEditingController();
  TextEditingController notesEditingController = TextEditingController();
  late JournalModel journalModel;
  List<Widget> journalPages = [];

  int index = 0;

  @override
  void initState() {
    super.initState();
    journalPages.add(const MoodSelectWidget());
    journalPages.add(
      TitleTextFieldWidget(textEditingController: titleEditingController),
    );
    journalPages.add(
      NotesTextFieldWidget(textEditingController: notesEditingController),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<JournalEditorProvider>(
      builder: (BuildContext context, value, Widget? child) {
        index = value.index;

        return WillPopScope(
          onWillPop: () async {
            if (index == 0) {
              Navigator.pop(context);
              return false;
            }
            index -= 1;
            value.updateIndex(index);
            return false;
          },
          child: Scaffold(
              body: Stack(
            alignment: Alignment.center,
            clipBehavior: Clip.antiAlias,
            children: [
              Blur(
                blur: 2,
                blurColor: Colors.white,
                child: Positioned.fill(
                  child: SvgPicture.asset(
                    "assets/illustrations/bg.svg",
                    alignment: Alignment.center,
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              if (index <= 2)
                SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      journalPages[index],
                      SizedBox(
                        height: 10.h,
                      ),
                      InkWell(
                        onTap: () {
                          if (value.index == 2) {
                            journalModel = JournalModel(
                                journalId:
                                    (Random.secure().nextInt(90000) + 10000),
                                createdOn: DateTime.now(),
                                mood: Provider.of<JournalEditorProvider>(
                                        context,
                                        listen: false)
                                    .mood,
                                title: titleEditingController.text,
                                color: Color((Random().nextDouble() * 0xFFFFFF)
                                        .toInt())
                                    .withOpacity(1.0),
                                description: notesEditingController.text);
                          }
                          if (index == 1 && titleEditingController.text == "") {
                            return;
                          }
                          if (index == 2 && notesEditingController.text == "") {
                            return;
                          }
                          index += 1;

                          value.updateIndex(index);
                        },
                        child: Container(
                          padding: const EdgeInsets.all(10),
                          margin: const EdgeInsets.all(10),
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: kPrimaryColor,
                            borderRadius: BorderRadius.circular(40),
                          ),
                          child: Center(
                            child: Text(
                              "Next",
                              style: TextStyle(
                                fontSize: 24.sp,
                                color: Colors.white,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              if (index == 3) ViewJournalScreen(journalModel: journalModel),
            ],
          )),
        );
      },
    );
  }
}
