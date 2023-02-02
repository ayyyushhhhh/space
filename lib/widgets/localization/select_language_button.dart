import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SelectLanguageButton extends StatelessWidget {
  final VoidCallback selectLanguage;
  final String language;
  final String locale;
  const SelectLanguageButton(
      {super.key,
      required this.selectLanguage,
      required this.language,
      required this.locale});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: selectLanguage,
      child: Container(
        padding: const EdgeInsets.all(10),
        margin: const EdgeInsets.all(10),
        height: 50.h,
        width: 150.w,
        decoration: BoxDecoration(
          border: (context.locale.toString() == locale)
              ? Border.all(
                  color: const Color(0xFFD2C6FF),
                )
              : Border.all(color: Colors.transparent),
          borderRadius: BorderRadius.circular(40),
        ),
        child: Center(
          child: Text(
            language,
            style: const TextStyle(fontWeight: FontWeight.w500),
          ),
        ),
      ),
    );
  }
}
