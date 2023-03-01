import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:space/notification%20manager/notification_manager.dart';
import 'package:space/screens/localization/lanuage_string_data.dart';
import 'package:space/utils/ui_colors.dart';
import 'package:space/utils/pref.dart';

// ignore: must_be_immutable
class NotificationWidget extends StatelessWidget {
  NotificationWidget({super.key});

  bool _canNotify = SharedPreferencesHelper.getNotificationPermission();
  Duration _notificationTime = SharedPreferencesHelper.getNotificationTime();
  void _showDialog({
    required Widget child,
    required BuildContext context,
  }) {
    showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) => Container(
        height: 260.h,
        padding: const EdgeInsets.only(top: 10.0),
        margin: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        color: CupertinoColors.systemBackground.resolveFrom(context),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            SizedBox(height: 180.h, child: child),
            CupertinoButton(
              child: const Text('Set'),
              onPressed: () {
                _showNotification();
                SharedPreferencesHelper.saveNotificationTime(_notificationTime);
                Navigator.of(context).pop();
              },
            )
          ],
        ),
      ),
    );
  }

  void _showNotification() {
    NotificationManger.showNotificationDaily(
      title: "Have Something to Write?",
      body: "Add it to your Journal!",
      time: Time(
        _notificationTime.inHours,
        _notificationTime.inMinutes.remainder(60),
      ),
    );
  }

  void requestNotificationPermission() async {
    if (await Permission.notification.isDenied) {
      await Permission.notification.request();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(5),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: const BorderRadius.all(Radius.circular(10))),
      child: Theme(
        data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
        child: StatefulBuilder(
          builder:
              (BuildContext context, void Function(void Function()) setState) {
            return ExpansionTile(
              tilePadding: EdgeInsets.zero,
              initiallyExpanded: true,
              textColor: Theme.of(context).textTheme.titleLarge?.color,
              title: Text(
                LanguageData.reminder.tr(),
                style: TextStyle(fontSize: 16.sp),
              ),
              trailing: Transform.scale(
                scale: 1.3,
                child: Semantics(
                  label: 'Turn on notification reminders',
                  hint: 'Press to Turn on notification reminders',
                  child: CupertinoSwitch(
                    activeColor: kPrimaryColor,
                    thumbColor: !_canNotify ? kPrimaryColor : Colors.white,
                    value: _canNotify,
                    onChanged: ((value) {
                      setState(
                        () {
                          _canNotify = value;

                          if (value == false) {
                            NotificationManger.cancelNotificationDaily();
                            SharedPreferencesHelper.saveAuthPermission(
                                _canNotify);
                            return;
                          }
                          requestNotificationPermission();
                          SharedPreferencesHelper.saveAuthPermission(
                              _canNotify);
                          _showNotification();
                        },
                      );
                    }),
                  ),
                ),
              ),
              children: [
                if (_canNotify == true)
                  ListTile(
                    title: Text(
                      LanguageData.setTime.tr(),
                      style: TextStyle(
                          fontWeight: FontWeight.w700, fontSize: 16.sp),
                    ),
                    trailing: Semantics(
                      label: 'set notification timer',
                      hint: 'Press to set notification timer',
                      child: InkWell(
                        onTap: (() {
                          _showDialog(
                              child: CupertinoTimerPicker(
                                mode: CupertinoTimerPickerMode.hm,
                                initialTimerDuration: _notificationTime,
                                onTimerDurationChanged: (Duration newDuration) {
                                  setState(
                                      () => _notificationTime = newDuration);
                                },
                              ),
                              context: context);
                        }),
                        child: Text(
                          "${_notificationTime.inHours.toString().padLeft(2, '0')}:${_notificationTime.inMinutes.remainder(60).toString().padLeft(2, '0')}",
                          style: TextStyle(
                              fontWeight: FontWeight.w700, fontSize: 16.sp),
                        ),
                      ),
                    ),
                  )
              ],
            );
          },
        ),
      ),
    );
  }
}
