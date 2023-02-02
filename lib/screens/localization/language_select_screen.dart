import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:space/screens/localization/lanuage_string_data.dart';
import 'package:space/screens/main_screen.dart';
import 'package:space/utils/constants.dart';
import 'package:space/widgets/localization/select_language_button.dart';

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
        padding: const EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 5.h,
            ),
            Center(
              child: Text(
                LanguageData.selectLang,
                style: TextStyle(
                  fontSize: 24.sp,
                  fontWeight: FontWeight.w700,
                  color: kPrimaryTextColor,
                ),
              ).tr(),
            ),
            Text(
              LanguageData.selectLang,
              style: TextStyle(
                fontSize: 20.sp,
                fontWeight: FontWeight.w500,
                color: kSecondaryTextColor,
              ),
            ).tr(),
            SizedBox(
              height: 10.h,
            ),
            ShaderMask(
              shaderCallback: (rect) {
                return const LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Colors.white, Colors.transparent],
                ).createShader(
                    Rect.fromLTRB(0, 0, rect.width, rect.height * 1.20));
              },
              blendMode: BlendMode.dstIn,
              child: SvgPicture.asset(
                "assets/illustrations/select_language.svg",
                height: 400.h,
                width: 260.w,
              ),
            ),
            SizedBox(
              height: 10.h,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SelectLanguageButton(
                  selectLanguage: () {
                    context.setLocale(
                      const Locale('en', 'US'),
                    );
                  },
                  language: "English",
                  locale: 'en_US',
                ),
                SelectLanguageButton(
                  selectLanguage: () {
                    context.setLocale(
                      const Locale('hi', 'IN'),
                    );
                  },
                  language: "हिंदी",
                  locale: 'hi_IN',
                )
              ],
            ),
            SizedBox(
              height: 10.h,
            ),
            InkWell(
              onTap: () {
                Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (BuildContext context) {
                  return const MainScreen();
                }));
              },
              child: Container(
                padding: const EdgeInsets.all(10),
                margin: const EdgeInsets.all(10),
                width: double.infinity,
                decoration: BoxDecoration(
                  color: kPrimaryColor,
                  borderRadius: BorderRadius.circular(40),
                ),
                child: Center(
                  child: Text(
                    LanguageData.continueNext,
                    style: TextStyle(
                      fontSize: 24.sp,
                      color: Colors.white,
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
