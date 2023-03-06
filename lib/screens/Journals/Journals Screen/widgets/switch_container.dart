import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SwitchContainer extends StatelessWidget {
  final IconData leadingIcon;
  final String title;
  final String description;
  final Widget switchWidget;
  final Color backgroundColor;
  final Color textColor;
  const SwitchContainer(
      {super.key,
      required this.leadingIcon,
      required this.title,
      required this.description,
      required this.switchWidget,
      required this.backgroundColor,
      required this.textColor});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(5),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: const BorderRadius.all(
          Radius.circular(10),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(
            leadingIcon,
            size: 25.r,
            color: textColor,
          ),
          SizedBox(
            width: 10.w,
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  // LanguageData.appTheme.tr(),
                  style: TextStyle(
                      fontSize: 22.sp,
                      fontWeight: FontWeight.w600,
                      color: textColor),
                ),
                Text(
                  description,
                  // LanguageData.appthemeswitchDialog.tr(),
                  maxLines: 2,
                  softWrap: true,
                  style: TextStyle(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w400,
                    color: textColor,
                  ),
                ),
              ],
            ),
          ),
          switchWidget,
        ],
      ),
    );
  }
}
