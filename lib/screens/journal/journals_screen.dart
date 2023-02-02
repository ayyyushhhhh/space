import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:space/provider/journal/journal_provider.dart';
import 'package:space/screens/localization/lanuage_string_data.dart';
import 'package:space/utils/constants.dart';
import 'package:space/widgets/journal/calendar_widget.dart';
import 'package:space/widgets/journal/journal_widget.dart';

class JournalsScreen extends StatefulWidget {
  const JournalsScreen({super.key});

  @override
  State<JournalsScreen> createState() => _JournalsScreenState();
}

class _JournalsScreenState extends State<JournalsScreen> {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(statusBarColor: kSecondaryColor));
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
                fontSize: 30.sp,
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
                      child: const Center(child: Text("Oops Nothing Found!"))));
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
      ],
    ));
  }
}
