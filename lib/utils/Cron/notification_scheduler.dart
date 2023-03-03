import 'package:cron/cron.dart';
import 'package:flutter/material.dart';

class CronNotificationScheduler {
  final Cron cron = Cron();
  void pickRandomTitleForNotification(
      {required VoidCallback notificationCall}) async {
    try {
      cron.schedule(Schedule.parse('*/6 * * * * *'), () {
        print(DateTime.now());
      });

      // await Future.delayed(const Duration(seconds: 20));
      await cron.close();
    } on ScheduleParseException {
      await cron.close();
    }
  }
}
