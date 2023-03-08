import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:space/screens/localization/lanuage_string_data.dart';
import 'package:space/screens/Main%20Screen/main_screen.dart';
import 'package:space/screens/localization/widgets/select_language_button.dart';
import 'package:space/utils/ui_colors.dart';
import 'package:space/utils/pref.dart';

class LanguageSelectScreen extends StatefulWidget {
  const LanguageSelectScreen({super.key});

  @override
  State<LanguageSelectScreen> createState() => _LanguageSelectScreenState();
}

class _LanguageSelectScreenState extends State<LanguageSelectScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 5.h,
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                LanguageData.selectLang,
                style: TextStyle(
                  fontSize: 36.sp,
                  fontWeight: FontWeight.w600,
                  color: kPrimaryTextColor,
                ),
              ).tr(),
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Choose the language in which you want to see the content",
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w400,
                  color: const Color(0xFF323945),
                ),
              ).tr(),
            ),
            SizedBox(
              height: 10.h,
            ),
            SvgPicture.asset(
              "assets/illustrations/select_language.svg",
              height: 300.h,
              width: 200.w,
            ),
            SizedBox(
              height: 10.h,
            ),
            SelectLanguageButton(
              selectLanguage: () {
                context.setLocale(
                  const Locale('en', 'US'),
                );
              },
              language: "English",
              locale: 'en_US',
            ),
            SizedBox(
              height: 20.h,
            ),
            SelectLanguageButton(
              selectLanguage: () {
                context.setLocale(
                  const Locale('hi', 'IN'),
                );
              },
              language: "हिंदी",
              locale: 'hi_IN',
            ),
            SizedBox(
              height: 10.h,
            ),
            InkWell(
              onTap: () {
                Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(
                  builder: (BuildContext context) {
                    SharedPreferencesHelper.saveLocale(hasLocale: true);
                    return const MainScreen();
                  },
                ), (Route<dynamic> route) => false);
              },
              child: Container(
                padding: const EdgeInsets.all(10),
                margin: const EdgeInsets.all(10),
                width: 250.w,
                height: 50.h,
                decoration: BoxDecoration(
                  color: const Color(0xFFE7E5FD),
                  borderRadius: BorderRadius.circular(40),
                ),
                child: Center(
                  child: Text(
                    LanguageData.continueNext,
                    style: TextStyle(
                      fontSize: 16.sp,
                      color: kPrimaryColor,
                      fontWeight: FontWeight.w500,
                    ),
                  ).tr(),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
