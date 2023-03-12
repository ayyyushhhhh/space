import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:space/utils/pref.dart';

import 'package:space/utils/ui_colors.dart';

class NotificationSwitch extends StatelessWidget {
  const NotificationSwitch({super.key});

  @override
  Widget build(BuildContext context) {
    bool canNotify = SharedPreferencesHelper.getNotificationPermission();
    return StatefulBuilder(
      builder: (BuildContext context, void Function(void Function()) setState) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Transform.scale(
              scale: 1.3,
              child: Semantics(
                label: 'Notification Button',
                hint: 'Switch to accept Notification',
                child: CupertinoSwitch(
                  value: canNotify,
                  trackColor: Colors.white,
                  activeColor: kPrimaryColor,
                  thumbColor: !canNotify ? kPrimaryColor : Colors.white,
                  onChanged: (bool value) {
                    setState(
                      () {
                        canNotify = value;

                        SharedPreferencesHelper.saveNotificationPermission(
                            value);
                      },
                    );
                  },
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
