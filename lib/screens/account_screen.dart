import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:space/utils/pref.dart';

import '../widgets/theme/theme_switch.dart';

// ignore: must_be_immutable
class AccountScreen extends StatelessWidget {
  AccountScreen({super.key});

  bool _canAuth = SharedPreferencesHelper.getAuthPermission();
  bool _canNotify = false;
  Duration _notificationTime = const Duration(hours: 20, minutes: 00);
  void _showDialog({required Widget child, required BuildContext context}) {
    showCupertinoModalPopup<void>(
        context: context,
        builder: (BuildContext context) => Container(
              height: 216.h,
              padding: const EdgeInsets.only(top: 6.0),
              margin: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom,
              ),
              color: CupertinoColors.systemBackground.resolveFrom(context),
              child: SafeArea(
                top: false,
                child: child,
              ),
            ));
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
                        textColor: Colors.black,
                        initiallyExpanded: true,
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
                                  "${_notificationTime.inHours}:${_notificationTime.inMinutes.remainder(60)}",
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
