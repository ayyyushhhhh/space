import 'package:timezone/timezone.dart' as tz;

import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationManger {
  static final _notification = FlutterLocalNotificationsPlugin();

  static Future<NotificationDetails> _notificationDetails() async {
    return const NotificationDetails(
      android: AndroidNotificationDetails(
        "channel id 4",
        "channel name",
        importance: Importance.max,
      ),
    );
  }

  static Future init({bool initSchedule = false}) async {
    AndroidInitializationSettings androidSettings =
        const AndroidInitializationSettings("@mipmap/ic_launcher");
    InitializationSettings initializationSettings =
        InitializationSettings(android: androidSettings);

    await _notification.initialize(initializationSettings);
  }

//   static Future showNotification({
//     int id = 0,
//     String? title,
//     String? body,
//     String? payload,
//   }) async {
//     return _notification.show(
//       id,
//       title,
//       body,
//       await _notificationDetails(),
//       payload: payload,
//     );
//   }

  static Future showScheduleNotification({
    int id = 0,
    String? title,
    String? body,
    String? payload,
    required DateTime scheduledDate,
  }) async {
    return _notification.zonedSchedule(
      id,
      title,
      body,
      tz.TZDateTime.from(scheduledDate, tz.UTC),
      await _notificationDetails(),
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
      androidAllowWhileIdle: true,
    );
  }

  static Future showNotificationDaily({
    int id = 0,
    required String title,
    required String body,
    String? payload,
    required Time time,
  }) async {
    return _notification.zonedSchedule(
      id,
      title,
      body,
      _scheduleTime(time),
      await _notificationDetails(),
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
      androidAllowWhileIdle: true,
      matchDateTimeComponents: DateTimeComponents.time,
    );
  }

  static tz.TZDateTime _scheduleTime(Time time) {
    final DateTime scheduledDate = DateTime(
      DateTime.now().year,
      DateTime.now().month,
      DateTime.now().day,
      time.hour,
      time.minute,
    );

    final scheduleDate = tz.TZDateTime.from(scheduledDate, tz.local);
    return scheduleDate.isBefore(DateTime.now())
        ? scheduleDate.add(const Duration(days: 1))
        : scheduleDate;
  }
}
