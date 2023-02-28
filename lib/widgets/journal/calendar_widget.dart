import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:space/provider/journal/journal_provider.dart';
import 'package:space/utils/constants.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarWidget extends StatelessWidget {
  const CalendarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<JournalProvider>(
      builder: (BuildContext context, value, Widget? child) {
        return TableCalendar(
          rowHeight: 80.h,
          headerVisible: true,
          headerStyle: HeaderStyle(
              formatButtonVisible: false,
              titleTextFormatter: (date, locale) {
                if (DateFormat.yMd().format(date) ==
                    DateFormat.yMd().format(DateTime.now())) {
                  return "Today, ${DateFormat.MMMd(context.locale.toString()).format(date)}";
                }
                return DateFormat.MMMEd(context.locale.toString()).format(date);
              },
              titleCentered: true,
              leftChevronIcon: Icon(
                Icons.chevron_left,
                size: 30.r,
                color: Colors.black,
              ),
              rightChevronIcon: Icon(
                Icons.chevron_right,
                size: 30.r,
                color: Colors.black,
              ),
              titleTextStyle: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w500,
                  color: kPrimaryTextColor)),
          calendarFormat: CalendarFormat.week,
          focusedDay: value.getDate,
          firstDay: DateTime(2019, 06, 13),
          lastDay: DateTime(2025, 12, 31),
          selectedDayPredicate: (day) {
            return isSameDay(value.getDate, day);
          },
          onDaySelected: (selectedDay, focusedDay) {
            value.updateDate(selectedDay);
          },
          calendarBuilders: CalendarBuilders(
            todayBuilder: (context, dateTimeNow, datetime) {
              return Container(
                margin: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.transparent,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      DateFormat.E(context.locale.toString())
                          .format(DateTime.now()),
                      style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w400,
                          color: kSecondaryTextColor),
                    ),
                    SizedBox(
                      height: 5.h,
                    ),
                    Text(
                      DateFormat.d().format(DateTime.now()),
                      style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w500,
                          color: kPrimaryTextColor),
                    ),
                  ],
                ),
              );
            },
            defaultBuilder: (context, dateTime, date) {
              return Container(
                margin: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.transparent,
                ),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        DateFormat.E(context.locale.toString())
                            .format(dateTime),
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w400,
                          color: kSecondaryTextColor,
                        ),
                      ),
                      SizedBox(
                        height: 5.h,
                      ),
                      Text(
                        DateFormat.d().format(dateTime),
                        style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w500,
                            color: kPrimaryTextColor),
                      ),
                    ],
                  ),
                ),
              );
            },
            selectedBuilder: (context, day, focusedDay) {
              return Container(
                margin: const EdgeInsets.all(3),
                padding: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(40),
                  color: kPrimaryColor,
                ),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        DateFormat.E(context.locale.toString()).format(day),
                        style: TextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w400,
                            color: Colors.white),
                      ),
                      SizedBox(
                        height: 5.h,
                      ),
                      Text(
                        DateFormat.d().format(day),
                        style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w500,
                            color: Colors.white),
                      ),
                    ],
                  ),
                ),
              );
            },
            dowBuilder: (context, day) {
              return const Center(
                child: Text(
                  "",
                  style: TextStyle(fontSize: 0, fontWeight: FontWeight.bold),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
