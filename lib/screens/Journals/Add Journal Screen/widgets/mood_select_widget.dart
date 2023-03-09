import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:space/provider/journal/journal_editor_provider.dart';
import 'package:space/utils/ui_colors.dart';
import 'package:space/utils/utils_functions.dart';

class MoodSelectWidget extends StatelessWidget {
  const MoodSelectWidget({super.key});

  Widget _buildEmojiWidget({required String emoji}) {
    return Consumer<JournalEditorProvider>(
      builder: (context, mood, child) {
        return Expanded(
          child: InkWell(
            onTap: () {
              mood.changeMood(emoji);
            },
            child: AnimatedContainer(
              curve: Curves.linearToEaseOut,
              padding: EdgeInsets.zero,
              margin: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: mood.mood == emoji
                    ? kPrimaryColor
                    : const Color(0xFFE6E6EB),
                borderRadius: const BorderRadius.all(
                  Radius.circular(10),
                ),
              ),
              duration: const Duration(milliseconds: 300),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    "assets/emojis/$emoji.svg",
                    height: 40.h,
                    width: 40.w,
                  ),
                  SizedBox(
                    height: 5.h,
                  ),
                  Text(
                    emoji.toTitleCase(),
                    style: TextStyle(
                        fontSize: 9.sp,
                        fontWeight: FontWeight.w500,
                        color:
                            mood.mood == emoji ? Colors.white : Colors.black),
                  ),
                ],
              ),
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
          // padding: const EdgeInsets.all(10),
          margin: const EdgeInsets.all(10),
          decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(
                Radius.circular(20),
              ),
              color: Colors.white),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "How Are You Feeling Right Now?",
                style: TextStyle(
                    fontSize: 33.sp,
                    color: Colors.black,
                    fontWeight: FontWeight.w600),
              ),
              SizedBox(
                height: 5.h,
              ),
              Column(
                children: [
                  SizedBox(
                    height: 100.h,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        _buildEmojiWidget(emoji: 'amazed'),
                        _buildEmojiWidget(emoji: 'angry'),
                        _buildEmojiWidget(emoji: 'confused'),
                        _buildEmojiWidget(emoji: 'crying'),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 100.h,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        _buildEmojiWidget(emoji: 'happy'),
                        _buildEmojiWidget(emoji: 'hungry'),
                        _buildEmojiWidget(emoji: 'hush'),
                        _buildEmojiWidget(emoji: 'joyful'),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 100.h,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        _buildEmojiWidget(emoji: 'loving'),
                        _buildEmojiWidget(emoji: 'neutral'),
                        _buildEmojiWidget(emoji: 'persist'),
                        _buildEmojiWidget(emoji: 'relieved'),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 100.h,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        _buildEmojiWidget(emoji: 'rofl'),
                        _buildEmojiWidget(emoji: 'sad'),
                        _buildEmojiWidget(emoji: 'sick'),
                        _buildEmojiWidget(emoji: 'worried'),
                      ],
                    ),
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
