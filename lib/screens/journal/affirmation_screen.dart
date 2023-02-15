import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:space/screens/main_screen.dart';
import 'package:space/utils/affirmations.dart';
import 'package:space/utils/constants.dart';
import 'package:space/utils/pref.dart';

import '../../auth/local_auth/local_authentication.dart';

class AffirmationScreen extends StatelessWidget {
  const AffirmationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ShaderMask(
              shaderCallback: (rect) {
                return const LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Colors.white, Colors.transparent],
                ).createShader(
                    Rect.fromLTRB(0, 0, rect.width, rect.height * 1.20));
              },
              blendMode: BlendMode.dstIn,
              child: SvgPicture.asset(
                "assets/illustrations/lets_dig_in.svg",
                height: 400.h,
                width: 300.w,
              ),
            ),
            SizedBox(
              height: 10.h,
            ),
            Text(
              "\""
              "${affirmations[Random().nextInt(affirmations.length)]}"
              "\"",
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 10.h,
            ),
            InkWell(
              onTap: () async {
                NavigatorState navigator = Navigator.of(context);
                await _authenticate();
                navigator.pushAndRemoveUntil(MaterialPageRoute(
                  builder: (BuildContext context) {
                    return const MainScreen();
                  },
                ), (Route<dynamic> route) => false);
              },
              child: Container(
                padding: const EdgeInsets.all(10),
                margin: const EdgeInsets.all(10),
                width: double.infinity,
                decoration: BoxDecoration(
                  color: kPrimaryColor,
                  borderRadius: BorderRadius.circular(40),
                ),
                child: Center(
                  child: Text(
                    "Let's Go",
                    style: TextStyle(
                      fontSize: 24.sp,
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Future<void> _authenticate() async {
    if (SharedPreferencesHelper.getAuthPermission() == true) {
      await LocalAuthApi.authenticate();
    }
  }
}
