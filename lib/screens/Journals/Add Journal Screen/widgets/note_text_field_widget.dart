import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:space/models/journals/journal_model.dart';
import 'package:space/provider/journal/journal_editor_provider.dart';
import 'package:space/screens/Journals/Add%20Journal%20Screen/widgets/button_container.dart';
import 'package:space/screens/Journals/Add%20Journal%20Screen/widgets/journal_progress_indication.dart';
import 'package:space/utils/ui_colors.dart';

class NotesTextFieldWidget extends StatelessWidget {
  const NotesTextFieldWidget({super.key});

  @override
  Widget build(BuildContext context) {
    JournalEditorProvider journalEditorProvider =
        Provider.of<JournalEditorProvider>(context, listen: false);
    return Scaffold(
        body: SingleChildScrollView(
      child: Container(
        margin: const EdgeInsets.all(20),
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height * 0.9,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () {
                          journalEditorProvider.updateIndex(1);
                        },
                        child: Icon(
                          Icons.arrow_back,
                          size: 30.r,
                        ),
                      ),
                      JournalProgressIndicator(
                        value: 3,
                        width: 200.w,
                        height: 10.h,
                        currentVal: journalEditorProvider.index + 1,
                      ),
                      Text(
                        "${journalEditorProvider.index + 1}/3",
                        style: TextStyle(
                            fontSize: 14.sp, fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10, right: 10),
                  child: Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                            text: 'Express Your ',
                            style: TextStyle(
                                fontSize: 30.sp, fontWeight: FontWeight.w600)),
                        TextSpan(
                          text: ' Feelings ',
                          style: TextStyle(
                              fontSize: 30.sp,
                              fontWeight: FontWeight.w600,
                              color: kPrimaryColor),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 20.h,
                ),
                Container(
                  height: 350.h,
                  width: double.infinity,
                  margin: const EdgeInsets.only(left: 10, right: 10),
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                  ),
                  child: Semantics(
                    label: 'Enter journal desciption',
                    hint: 'Press to enter journal description',
                    child: TextField(
                      controller: journalEditorProvider.notesEditingController,
                      keyboardType: TextInputType.multiline,
                      textInputAction: TextInputAction.newline,
                      textAlignVertical: TextAlignVertical.top,
                      expands: true,
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.all(10),
                        fillColor: Theme.of(context).cardColor,
                        filled: true,
                        border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
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
            InkWell(
              onTap: () {
                if (journalEditorProvider.notesEditingController.text == "") {
                  return;
                }
                JournalModel journalModel = JournalModel(
                    journalId: (Random.secure().nextInt(90000) + 10000),
                    createdOn: DateTime.now(),
                    mood: Provider.of<JournalEditorProvider>(context,
                            listen: false)
                        .mood,
                    title: journalEditorProvider.titleEditingController.text,
                    color: Color((Random().nextDouble() * 0xFFFFFF).toInt())
                        .withOpacity(1.0),
                    description:
                        journalEditorProvider.notesEditingController.text);
                journalEditorProvider.updateJournal(journalModel);
                journalEditorProvider.updateIndex(3);
              },
              child: const ButtonContainer(label: "Done"),
            ),
          ],
        ),
      ),
    ));
  }
}
