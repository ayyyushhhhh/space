import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:space/utils/ui_colors.dart';

class SelectLanguageButton extends StatelessWidget {
  final VoidCallback selectLanguage;
  final String language;
  final String locale;
  const SelectLanguageButton(
      {super.key,
      required this.selectLanguage,
      required this.language,
      required this.locale});

  bool _isSelected(BuildContext context) {
    if ((context.locale.toString() == locale)) {
      return true;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: selectLanguage,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            language,
            style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 17.sp,
                color: _isSelected(context)
                    ? const Color(0xFF323945)
                    : const Color(0xFFA4A4A7)),
          ),
          SizedBox(
            width: 30.w,
          ),
          Icon(
            Icons.done,
            weight: 17.sp,
            color: _isSelected(context) ? kPrimaryColor : Colors.transparent,
          )
        ],
      ),
    );
  }
}
