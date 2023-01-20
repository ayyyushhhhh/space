import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:space/utils/App%20State/app_state_provider.dart';

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
              CupertinoIcons.brightness,
              color: Colors.yellow,
            ),
            SizedBox(
              width: 10.w,
            ),
            Transform.scale(
              scale: 1.3,
              child: Semantics(
                label: 'Change Theme',
                hint: 'Press to change  Theme',
                child: CupertinoSwitch(
                  value: theme.isDarkMode,
                  activeColor: Theme.of(context).primaryColor,
                  onChanged: (bool value) {
                    theme.updateTheme(value);
                  },
                ),
              ),
            ),
            SizedBox(
              width: 10.w,
            ),
            const Icon(
              CupertinoIcons.moon_stars_fill,
              color: Colors.blueAccent,
            ),
          ],
        );
      },
    );
  }
}
