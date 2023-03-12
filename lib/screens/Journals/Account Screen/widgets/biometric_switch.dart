import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:space/auth/local_auth/local_authentication.dart';
import 'package:space/utils/pref.dart';

import 'package:space/utils/ui_colors.dart';

class BiometricSwitch extends StatelessWidget {
  const BiometricSwitch({super.key});

  @override
  Widget build(BuildContext context) {
    bool canAuth = SharedPreferencesHelper.getAuthPermission();
    return StatefulBuilder(
      builder: (BuildContext context, void Function(void Function()) setState) {
        return Transform.scale(
          scale: 1.3,
          child: Semantics(
            label: 'Use Biometric to unlock app',
            hint: 'Press to turn on/off feature',
            child: CupertinoSwitch(
              activeColor: kPrimaryColor,
              trackColor: Colors.white,
              thumbColor: !canAuth ? kPrimaryColor : Colors.white,
              value: canAuth,
              onChanged: ((value) {
                setState(
                  () {
                    canAuth = value;
                    if (canAuth == true) {
                      LocalAuthApi.authenticate();
                    }
                    SharedPreferencesHelper.saveAuthPermission(value);
                  },
                );
              }),
            ),
          ),
        );
      },
    );
  }
}
