import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:space/utils/theme/app_state_provider.dart';

class ThemeSwitch extends StatelessWidget {
  const ThemeSwitch({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<AppStateProvider>(
      builder: (BuildContext context, theme, Widget? child) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Icon(
              Icons.sunny,
              color: Colors.yellow,
            ),
            SizedBox(
              width: 10.w,
            ),
            CupertinoSwitch(
              value: theme.isDarkMode,
              onChanged: (bool value) {
                theme.updateTheme(value);
              },
            ),
            SizedBox(
              width: 10.w,
            ),
            const Icon(
              Icons.dark_mode,
              color: Colors.blueAccent,
            ),
          ],
        );
      },
    );
  }
}
