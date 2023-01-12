import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:space/provider/journal/journalProvider.dart';
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
    return SafeArea(
      child: Scaffold(
          body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Container(
              height: 200.h,
              decoration: BoxDecoration(
                color: Colors.purple.shade300,
                borderRadius: BorderRadius.vertical(
                  bottom: Radius.elliptical(
                      MediaQuery.of(context).size.width, 90.r),
                ),
              ),
              child: const CalendarWidget(),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Text(
                "Journals",
                style: TextStyle(
                  fontSize: 30.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          Consumer<JournalProvider>(
            builder: (BuildContext context, value, Widget? child) {
              List journals = value.journals;
              if (journals.isEmpty) {
                return const SliverToBoxAdapter(
                    child: Text("Oops Nothing Found!"));
              }
              return SliverList(
                  delegate: SliverChildBuilderDelegate(
                      childCount: journals.length, (context, index) {
                return JournalWidget(journalModel: journals[index]);
              }));
            },
          ),
        ],
      )),
    );
  }
}
