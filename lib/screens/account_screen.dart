import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:space/utils/pref.dart';

import '../widgets/theme/theme_switch.dart';

// ignore: must_be_immutable
class AccountScreen extends StatelessWidget {
  AccountScreen({super.key});

  bool _canAuth = SharedPreferencesHelper.getAuthPermission();
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
              )
            ],
          ),
        ),
      ),
    );
  }
}
