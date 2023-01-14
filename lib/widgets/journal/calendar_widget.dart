import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:space/provider/journal/journal_provider.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarWidget extends StatelessWidget {
  const CalendarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<JournalProvider>(
      builder: (BuildContext context, value, Widget? child) {
        return TableCalendar(
          rowHeight: 80.h,
          headerStyle: HeaderStyle(
              formatButtonVisible: false,
              titleCentered: true,
              leftChevronIcon: Icon(
                Icons.chevron_left,
                size: 24.r,
              ),
              rightChevronIcon: Icon(
                Icons.chevron_right,
                size: 24.r,
              ),
              titleTextStyle: TextStyle(fontSize: 24.sp)),
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
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        DateFormat.E().format(DateTime.now()),
                        style: TextStyle(
                          fontSize: 10.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        DateFormat.d().format(DateTime.now()),
                        style: TextStyle(
                          fontSize: 20.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
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
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        DateFormat.E().format(dateTime),
                        style: TextStyle(
                          fontSize: 10.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        DateFormat.d().format(dateTime),
                        style: TextStyle(
                          fontSize: 20.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              );

              // return Center(
              //   child: Column(
              //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //     children: [
              //       Text(
              //         DateFormat.E().format(dateTime),
              //         style: TextStyle(
              //           color: Colors.blueGrey,
              //           fontSize: 10.sp,
              //           fontWeight: FontWeight.bold,
              //         ),
              //       ),
              //       const SizedBox(
              //         height: 5,
              //       ),
              //       Text(
              //         DateFormat.d().format(dateTime),
              //         style: TextStyle(
              //           // color: Colors.white,
              //           fontSize: 10.sp,
              //           fontWeight: FontWeight.bold,
              //         ),
              //       ),
              //     ],
              //   ),
              // );
            },
            selectedBuilder: (context, day, focusedDay) {
              return Container(
                margin: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Theme.of(context).cardColor,
                ),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        DateFormat.E().format(day),
                        style: TextStyle(
                          fontSize: 10.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        DateFormat.d().format(day),
                        style: TextStyle(
                          //color: Colors.white,
                          fontSize: 20.sp,
                          fontWeight: FontWeight.bold,
                        ),
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
