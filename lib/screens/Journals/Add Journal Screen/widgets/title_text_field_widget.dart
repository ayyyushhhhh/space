import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:space/provider/journal/journal_editor_provider.dart';

class TitleTextFieldWidget extends StatelessWidget {
  final TextEditingController textEditingController;

  const TitleTextFieldWidget({super.key, required this.textEditingController});

  String _buildTitleText(BuildContext context) {
    String mood =
        Provider.of<JournalEditorProvider>(context, listen: false).mood;
    if (mood == "happy") {
      return "Super happy to hear that! Tell me everything";
    } else if (mood == "loving") {
      return "Ah, someone is on cloud nine. Excited to hear your story!";
    } else if (mood == "sad") {
      return "Did anything make you feel frustrated? I'm all ears.";
    } else if (mood == "rofl") {
      return "I'm happy to laugh with you! ";
    } else if (mood == "worried") {
      return "What do you think is making you feel so bad right now?";
    } else if (mood == "joyful") {
      return "What made you smile today? ";
    }
    return "Oh! I See, Let's talk about it.";
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<JournalEditorProvider>(
      builder: (BuildContext context, value, Widget? child) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: Text(
                _buildTitleText(context),
                style: TextStyle(
                  fontSize: 36.sp,
                  fontWeight: FontWeight.w700,
                  color: Colors.black,
                ),
              ),
            ),
            // Padding(
            //   padding: const EdgeInsets.all(10.0),
            //   child: Text(
            //     "Oh! I See, Let's talk about it.",
            //     style: TextStyle(
            //         fontSize: 16.sp,
            //         fontWeight: FontWeight.w500,
            //         color: Colors.black),
            //   ),
            // ),
            Container(
              width: double.infinity,
              margin: const EdgeInsets.only(left: 10, right: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
              ),
              child: TextField(
                readOnly: value.readOnly,
                controller: textEditingController,
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
                maxLength: 50,
              ),
            ),
          ],
        );
      },
    );
  }
}
