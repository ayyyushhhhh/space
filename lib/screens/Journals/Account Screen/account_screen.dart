import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:space/screens/Journals/Account%20Screen/widgets/account_widget.dart';
import 'package:space/screens/Journals/Account%20Screen/widgets/biometric_switch.dart';
import 'package:space/screens/Journals/Account%20Screen/widgets/notification_switch.dart';
import 'package:space/screens/Journals/Journals%20Screen/widgets/switch_container.dart';
import 'package:space/screens/localization/lanuage_string_data.dart';
import 'package:space/utils/ui_colors.dart';
import 'package:space/utils/utils_functions.dart';
import 'package:space/screens/Journals/Account%20Screen/widgets/notification_widget.dart';

import 'widgets/theme_switch.dart';

// ignore: must_be_immutable
class AccountScreen extends StatelessWidget {
  const AccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: Colors.white,
        statusBarIconBrightness: getSystemNavBarBrightness(context),
        systemNavigationBarColor: getBottomNavBarColorbyTheme(context),
        systemNavigationBarIconBrightness: getSystemNavBarBrightness(context),
      ),
    );
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 40.h,
              ),
              const AccountWidget(),
              SizedBox(
                height: 20.h,
              ),
              SwitchContainer(
                leadingIcon: Icons.dark_mode_outlined,
                title: LanguageData.appTheme.tr(),
                description: LanguageData.appthemeswitchDialog.tr(),
                switchWidget: const ThemeSwitch(),
                backgroundColor: kAccountPrimaryColor,
                textColor: Colors.white,
              ),
              SwitchContainer(
                leadingIcon: Icons.fingerprint,
                title: LanguageData.useBiometric.tr(),
                description: LanguageData.appthemeBiometricDialog.tr(),
                switchWidget: const BiometricSwitch(),
                backgroundColor: Theme.of(context).cardColor,
                textColor: Colors.black,
              ),
              NotificationWidget(),
              SwitchContainer(
                leadingIcon: Icons.language,
                title: LanguageData.selectLang.tr(),
                description: "Chose Your Language",
                switchWidget: Icon(
                  Icons.chevron_right,
                  size: 25.r,
                ),
                backgroundColor: Theme.of(context).cardColor,
                textColor: Colors.black,
              ),
              SwitchContainer(
                leadingIcon: Icons.notifications_active_outlined,
                title: "Notifications",
                description: "Do you need daily Notifications?",
                switchWidget: const NotificationSwitch(),
                backgroundColor: Theme.of(context).cardColor,
                textColor: Colors.black,
              ),
              InkWell(
                onTap: () {
                  openPlayStore();
                },
                child: SwitchContainer(
                  leadingIcon: Icons.reviews_outlined,
                  title: "Rate Us",
                  description:
                      "We would love to know what you think of our app",
                  switchWidget: Icon(
                    Icons.chevron_right,
                    size: 25.r,
                  ),
                  backgroundColor: Theme.of(context).cardColor,
                  textColor: Colors.black,
                ),
              ),
              SwitchContainer(
                leadingIcon: Icons.reviews_outlined,
                title: "About Space",
                description: "v2.0.0", // TODO : Change Version here
                switchWidget: Icon(
                  Icons.chevron_right,
                  size: 25.r,
                ),
                backgroundColor: Theme.of(context).cardColor,
                textColor: Colors.black,
              ),
              SizedBox(
                height: 70.h,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
