import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:space/provider/journal/journal_provider.dart';
import 'package:space/screens/localization/lanuage_string_data.dart';
import 'package:space/utils/ui_colors.dart';
import 'package:space/screens/Journals/Journals%20Screen/widgets/calendar_widget.dart';
import 'package:space/screens/Journals/Journals%20Screen/widgets/journal_widget.dart';

class JournalsScreen extends StatefulWidget {
  const JournalsScreen({super.key});

  @override
  State<JournalsScreen> createState() => _JournalsScreenState();
}

class _JournalsScreenState extends State<JournalsScreen> {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: kSecondaryColor,
        systemNavigationBarColor: getBottomNavBarColorbyTheme(context),
        systemNavigationBarIconBrightness: getSystemNavBarBrightness(context),
      ),
    );
    return Scaffold(
        body: CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: Container(
            height: 220.h,
            padding: EdgeInsets.only(top: 30.r),
            decoration: const BoxDecoration(
              color: kSecondaryColor,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(40),
                bottomRight: Radius.circular(40),
              ),
            ),
            child: const CalendarWidget(),
          ),
        ),
        SliverToBoxAdapter(
          child: Padding(
            padding: EdgeInsets.all(10.r),
            child: Text(
              LanguageData.yourThoughts,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 24.sp,
                fontWeight: FontWeight.w500,
              ),
            ).tr(),
          ),
        ),
        Consumer<JournalProvider>(
          builder: (BuildContext context, value, Widget? child) {
            List journals = value.journals;
            if (journals.isEmpty) {
              return SliverToBoxAdapter(
                  child: Padding(
                padding: EdgeInsets.all(10.r),
                child: SvgPicture.asset(
                  "assets/illustrations/no_journals.svg",
                  height: 200.h,
                ),
              ));
            }
            return SliverList(
              delegate: SliverChildBuilderDelegate(
                childCount: journals.length,
                (context, index) {
                  return JournalWidget(journalModel: journals[index]);
                },
              ),
            );
          },
        ),
        SliverToBoxAdapter(
          child: SizedBox(height: 80.h),
        ),
      ],
    ));
  }
}
