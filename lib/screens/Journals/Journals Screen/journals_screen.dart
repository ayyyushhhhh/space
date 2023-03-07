import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:space/hive%20boxes/journal_box.dart';
import 'package:space/provider/journal/journal_provider.dart';
import 'package:space/screens/Journals/Journals%20Screen/widgets/data_widget.dart';
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
        statusBarColor: Colors.white,
        statusBarIconBrightness: getSystemNavBarBrightness(context),
        systemNavigationBarColor: getBottomNavBarColorbyTheme(context),
        systemNavigationBarIconBrightness: getSystemNavBarBrightness(context),
      ),
    );
    JournalHiveBox.getMonthNumofEntries(dateTime: DateTime.now());
    return Scaffold(
        body: CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: SizedBox(height: 30.h),
        ),
        SliverToBoxAdapter(
          child: Container(
            padding: const EdgeInsets.all(20),
            margin: const EdgeInsets.only(left: 20, right: 20),
            width: double.infinity,
            decoration: const BoxDecoration(
              color: kJournalSecondayColor,
              borderRadius: BorderRadius.all(
                Radius.circular(20),
              ),
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                              text: 'Your Entries \nin ',
                              style: TextStyle(
                                  fontSize: 36.sp,
                                  fontWeight: FontWeight.w700)),
                          TextSpan(
                            text: 'March',
                            recognizer: TapGestureRecognizer()..onTap = () {},
                            style: TextStyle(
                                fontSize: 36.sp,
                                fontWeight: FontWeight.w700,
                                color: kCalendarPrimaryColor),
                          ),
                          WidgetSpan(
                            child: Icon(Icons.arrow_drop_down,
                                size: 20.r, color: kCalendarPrimaryColor),
                          ),
                        ],
                      ),
                    ),
                    CircleAvatar(
                      radius: 30.r,
                      child: const Text("A"),
                    )
                  ],
                ),
                Row(
                  children: [
                    Consumer<JournalProvider>(
                      builder: (BuildContext context, value, Widget? child) {
                        return FutureBuilder(
                          future: JournalHiveBox.getMonthNumofEntries(
                            dateTime: value.getDate,
                          ),
                          builder: (BuildContext context,
                              AsyncSnapshot<dynamic> snapshot) {
                            if (snapshot.hasData) {
                              int entries = snapshot.data as int;
                              return DataWidget(
                                  icon: Icons.arrow_back,
                                  value: entries,
                                  title: "Entries");
                            }
                            return const DataWidget(
                                icon: Icons.arrow_back,
                                value: 0,
                                title: "Entries");
                          },
                        );
                      },
                    ),
                    SizedBox(
                      width: 20.w,
                    ),
                    const DataWidget(
                        icon: Icons.point_of_sale, value: 100, title: "Points"),
                  ],
                )
              ],
            ),
          ),
        ),
        SliverToBoxAdapter(
          child: Container(
            margin: const EdgeInsets.only(left: 20, right: 20),
            child: const CalendarWidget(),
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
