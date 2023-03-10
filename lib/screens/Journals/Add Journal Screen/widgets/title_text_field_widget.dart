import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:space/provider/journal/journal_editor_provider.dart';
import 'package:space/screens/Journals/Add%20Journal%20Screen/widgets/button_container.dart';
import 'package:space/screens/Journals/Add%20Journal%20Screen/widgets/journal_progress_indication.dart';

class TitleTextFieldWidget extends StatelessWidget {
  const TitleTextFieldWidget({super.key});

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
    } else if (mood == "relieved") {
      return "Great! Tell me.";
    } else if (mood == "neutral") {
      return "Sometimes it's okay not to be okay. I'm here if you want to share anything. ";
    } else if (mood == "confused") {
      return "You can tell me what's on your mind now; I won't judge you. ";
    } else if (mood == "crying") {
      return "Would you like to talk about it? I would happily listen to you. ";
    } else if (mood == "amazed") {
      return "What made you go like WOOOW! ";
    } else if (mood == "hungry") {
      return "We are on the same (plate) boat! ";
    } else if (mood == "angry") {
      return "You have your Space :) You can vent out here ";
    } else if (mood == "sick") {
      return "Hey, you'll be fine. How do you feel right now?";
    }
    return "Oh! I See, Let's talk about it.";
  }

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
                          journalEditorProvider.updateIndex(0);
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
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: Text(
                        _buildTitleText(context),
                        style: TextStyle(
                          fontSize: 30.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 40.h,
                    ),
                    Container(
                      width: double.infinity,
                      margin: const EdgeInsets.only(left: 10, right: 10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: TextField(
                        controller:
                            journalEditorProvider.titleEditingController,
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
                ),
              ],
            ),
            InkWell(
              onTap: () {
                if (journalEditorProvider.titleEditingController.text != "") {
                  journalEditorProvider.updateIndex(2);
                }
              },
              child: const ButtonContainer(label: "Next"),
            ),
          ],
        ),
      ),
    ));
  }
}
