import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:space/notification%20manager/notification_manager.dart';
import 'package:space/utils/pref.dart';

import '../widgets/theme/theme_switch.dart';

// ignore: must_be_immutable
class AccountScreen extends StatelessWidget {
  AccountScreen({super.key});

  bool _canAuth = SharedPreferencesHelper.getAuthPermission();
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
                NotificationManger.showNotificationDaily(
                  title: "",
                  body: "Knock Knock! It's time to write",
                  time: Time(
                    _notificationTime.inHours,
                    _notificationTime.inMinutes.remainder(60),
                  ),
                );
                SharedPreferencesHelper.saveNotificationTime(_notificationTime);
                Navigator.of(context).pop();
              },
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.all(5),
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                    color: Theme.of(context).cardColor,
                    borderRadius: const BorderRadius.all(Radius.circular(10))),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "App Theme",
                      style: TextStyle(fontSize: 24.sp),
                    ),
                    const ThemeSwitch(),
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.all(5),
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                    color: Theme.of(context).cardColor,
                    borderRadius: const BorderRadius.all(Radius.circular(10))),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Use Biometric",
                      style: TextStyle(fontSize: 24.sp),
                    ),
                    StatefulBuilder(
                      builder: (BuildContext context,
                          void Function(void Function()) setState) {
                        return CupertinoSwitch(
                          value: _canAuth,
                          onChanged: ((value) {
                            setState(
                              () {
                                _canAuth = value;
                                SharedPreferencesHelper.saveAuthPermission(
                                    value);
                              },
                            );
                          }),
                        );
                      },
                    ),
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.all(5),
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                    color: Theme.of(context).cardColor,
                    borderRadius: const BorderRadius.all(Radius.circular(10))),
                child: Theme(
                  data: Theme.of(context)
                      .copyWith(dividerColor: Colors.transparent),
                  child: StatefulBuilder(
                    builder: (BuildContext context,
                        void Function(void Function()) setState) {
                      return ExpansionTile(
                        tilePadding: EdgeInsets.zero,
                        initiallyExpanded: true,
                        textColor:
                            Theme.of(context).textTheme.titleLarge?.color,
                        title: Text(
                          "Reminder",
                          style: TextStyle(fontSize: 24.sp),
                        ),
                        trailing: CupertinoSwitch(
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
                                NotificationManger.showNotificationDaily(
                                  title: "",
                                  body: "Knock Knock! It's time to write",
                                  time: Time(
                                    _notificationTime.inHours,
                                    _notificationTime.inMinutes.remainder(60),
                                  ),
                                );
                                SharedPreferencesHelper.saveAuthPermission(
                                    _canNotify);
                              },
                            );
                          }),
                        ),
                        children: [
                          if (_canNotify == true)
                            ListTile(
                              title: Text(
                                "Set Time",
                                style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 20.sp),
                              ),
                              trailing: InkWell(
                                onTap: (() {
                                  _showDialog(
                                      child: CupertinoTimerPicker(
                                        mode: CupertinoTimerPickerMode.hm,
                                        initialTimerDuration: _notificationTime,
                                        onTimerDurationChanged:
                                            (Duration newDuration) {
                                          setState(() =>
                                              _notificationTime = newDuration);
                                        },
                                      ),
                                      context: context);
                                }),
                                child: Text(
                                  "${_notificationTime.inHours.toString().padLeft(2, '0')}:${_notificationTime.inMinutes.remainder(60).toString().padLeft(2, '0')}",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 20.sp),
                                ),
                              ),
                            )
                        ],
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
