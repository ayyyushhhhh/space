import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:space/provider/journal/journal_editor_provider.dart';
import 'package:space/utils/constants.dart';
import 'package:space/utils/utils_functions.dart';

class MoodSelectWidget extends StatelessWidget {
  const MoodSelectWidget({super.key});

  _buildEmojiWidget({required String emoji}) {
    return Consumer<JournalEditorProvider>(
      builder: (context, mood, child) {
        return InkWell(
          onTap: () {
            mood.changeMood(emoji);
          },
          child: Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: mood.mood == emoji ? kPrimaryColor : Colors.white,
              borderRadius: const BorderRadius.all(
                Radius.circular(30),
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  "assets/emojis/$emoji.svg",
                  height: 50.h,
                  width: 50.w,
                ),
                SizedBox(
                  height: 5.h,
                ),
                Text(
                  emoji.toTitleCase(),
                  style: TextStyle(
                      fontSize: 10.sp,
                      color: mood.mood == emoji ? Colors.white : Colors.black),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(10),
          margin: const EdgeInsets.all(10),
          decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(
                Radius.circular(20),
              ),
              color: Colors.white),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "How Are You Feeling Right Now?",
                style: TextStyle(fontSize: 20.sp, color: Colors.black),
              ),
              SizedBox(
                height: 5.h,
              ),
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      _buildEmojiWidget(emoji: 'amazed'),
                      _buildEmojiWidget(emoji: 'angry'),
                      _buildEmojiWidget(emoji: 'confused'),
                      _buildEmojiWidget(emoji: 'crying'),
                    ],
                  ),
                  SizedBox(
                    height: 5.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      _buildEmojiWidget(emoji: 'happy'),
                      _buildEmojiWidget(emoji: 'hungry'),
                      _buildEmojiWidget(emoji: 'hush'),
                      _buildEmojiWidget(emoji: 'joyful'),
                    ],
                  ),
                  SizedBox(
                    height: 5.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      _buildEmojiWidget(emoji: 'loving'),
                      _buildEmojiWidget(emoji: 'neutral'),
                      _buildEmojiWidget(emoji: 'persist'),
                      _buildEmojiWidget(emoji: 'relieved'),
                    ],
                  ),
                  SizedBox(
                    height: 5.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      _buildEmojiWidget(emoji: 'rofl'),
                      _buildEmojiWidget(emoji: 'sad'),
                      _buildEmojiWidget(emoji: 'sick'),
                      _buildEmojiWidget(emoji: 'worried'),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
