import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:space/provider/App%20State/app_state_provider.dart';
import 'package:space/utils/ui_colors.dart';

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
            Transform.scale(
              scale: 1.3,
              child: Semantics(
                label: 'Change Theme',
                hint: 'Press to change  Theme',
                child: CupertinoSwitch(
                  value: theme.isDarkMode,
                  trackColor: Colors.white,
                  activeColor: kPrimaryColor,
                  thumbColor: kPrimaryColor,
                  onChanged: (bool value) {
                    theme.updateTheme(value);
                    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
                      statusBarColor: Theme.of(context).scaffoldBackgroundColor,
                    ));
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
