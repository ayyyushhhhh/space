import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:space/provider/journal/journal_editor_provider.dart';

class NotesTextFieldWidget extends StatelessWidget {
  final TextEditingController textEditingController;
  const NotesTextFieldWidget({super.key, required this.textEditingController});

  @override
  Widget build(BuildContext context) {
    return Consumer<JournalEditorProvider>(
      builder: (context, value, child) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: Text(
                "How do you feel?",
                style: TextStyle(fontSize: 36.sp, fontWeight: FontWeight.w700),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text(
                "Write about your experience in brief.",
                style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w500),
              ),
            ),
            Container(
              width: double.infinity,
              height: 400.h,
              margin: const EdgeInsets.only(left: 10, right: 10),
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(20)),
              ),
              child: Semantics(
                label: 'Enter journal desciption',
                hint: 'Press to enter journal description',
                child: TextField(
                  controller: textEditingController,
                  readOnly: value.readOnly,
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
        );
      },
    );
  }
}
