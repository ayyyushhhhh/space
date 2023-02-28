import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:space/auth/local_auth/local_authentication.dart';
import 'package:space/screens/localization/lanuage_string_data.dart';
import 'package:space/utils/constants.dart';
import 'package:space/utils/pref.dart';
import 'package:space/utils/utils_functions.dart';
import 'package:space/widgets/journal/notification_widget.dart';

import '../widgets/theme/theme_switch.dart';

// ignore: must_be_immutable
class AccountScreen extends StatelessWidget {
  AccountScreen({super.key});

  bool _canAuth = SharedPreferencesHelper.getAuthPermission();

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
          statusBarColor: Theme.of(context).scaffoldBackgroundColor,
          systemNavigationBarColor: getBottomNavBarColorbyTheme(context),
          statusBarIconBrightness: getSystemNavBarBrightness(context)),
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
              NotificationWidget(),
              InkWell(
                onTap: () {
                  openPlayStore();
                },
                child: Container(
                  width: double.infinity,
                  margin: const EdgeInsets.all(5),
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      color: Theme.of(context).cardColor,
                      borderRadius:
                          const BorderRadius.all(Radius.circular(10))),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Rate Us",
                        style: TextStyle(fontSize: 16.sp),
                      ),
                      Text(
                        "We would love to know what you think of our app",
                        style: TextStyle(fontSize: 8.sp),
                      ),
                    ],
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
