import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:space/auth/local_auth/local_authentication.dart';
import 'package:space/notification%20manager/notification_manager.dart';
import 'package:space/screens/localization/lanuage_string_data.dart';
import 'package:space/utils/constants.dart';
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
                  title: "Had a Rough Day? ",
                  body: "Why don't you write it out?",
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
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: Theme.of(context).scaffoldBackgroundColor,
        systemNavigationBarColor: getColorbyTheme(context),
      ),
    );
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
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          LanguageData.appTheme.tr(),
                          style: TextStyle(fontSize: 16.sp),
                        ),
                        Text(
                          LanguageData.appthemeswitchDialog.tr(),
                          style: TextStyle(fontSize: 8.sp),
                        ),
                      ],
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
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          LanguageData.useBiometric.tr(),
                          style: TextStyle(fontSize: 16.sp),
                        ),
                        Text(
                          LanguageData.appthemeBiometricDialog.tr(),
                          style: TextStyle(fontSize: 8.sp),
                        ),
                      ],
                    ),
                    StatefulBuilder(
                      builder: (BuildContext context,
                          void Function(void Function()) setState) {
                        return Transform.scale(
                          scale: 1.3,
                          child: Semantics(
                            label: 'Use Biometric to unlock app',
                            hint: 'Press to turn on/off feature',
                            child: CupertinoSwitch(
                              activeColor: kPrimaryColor,
                              thumbColor:
                                  !_canAuth ? kPrimaryColor : Colors.white,
                              value: _canAuth,
                              onChanged: ((value) {
                                setState(
                                  () {
                                    _canAuth = value;
                                    if (_canAuth == true) {
                                      LocalAuthApi.authenticate();
                                    }
                                    SharedPreferencesHelper.saveAuthPermission(
                                        value);
                                  },
                                );
                              }),
                            ),
                          ),
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
                              thumbColor:
                                  !_canNotify ? kPrimaryColor : Colors.white,
                              value: _canNotify,
                              onChanged: ((value) {
                                setState(
                                  () {
                                    _canNotify = value;
                                    if (value == false) {
                                      NotificationManger
                                          .cancelNotificationDaily();
                                      SharedPreferencesHelper
                                          .saveAuthPermission(_canNotify);
                                      return;
                                    }
                                    SharedPreferencesHelper.saveAuthPermission(
                                        _canNotify);
                                    NotificationManger.showNotificationDaily(
                                      title: "Have Something to Write?",
                                      body: "Add it to your Journal!",
                                      time: Time(
                                        _notificationTime.inHours,
                                        _notificationTime.inMinutes
                                            .remainder(60),
                                      ),
                                    );
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
                                    fontWeight: FontWeight.w700,
                                    fontSize: 16.sp),
                              ),
                              trailing: Semantics(
                                label: 'set notification timer',
                                hint: 'Press to set notification timer',
                                child: InkWell(
                                  onTap: (() {
                                    _showDialog(
                                        child: CupertinoTimerPicker(
                                          mode: CupertinoTimerPickerMode.hm,
                                          initialTimerDuration:
                                              _notificationTime,
                                          onTimerDurationChanged:
                                              (Duration newDuration) {
                                            setState(() => _notificationTime =
                                                newDuration);
                                          },
                                        ),
                                        context: context);
                                  }),
                                  child: Text(
                                    "${_notificationTime.inHours.toString().padLeft(2, '0')}:${_notificationTime.inMinutes.remainder(60).toString().padLeft(2, '0')}",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w700,
                                        fontSize: 16.sp),
                                  ),
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
