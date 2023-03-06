import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AccountWidget extends StatelessWidget {
  const AccountWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Stack(
          children: [
            Container(
              height: 90.h,
              width: 90.h,
              decoration: BoxDecoration(
                color: const Color(0xFFD9D9D9),
                boxShadow: const [
                  BoxShadow(
                    color: Color.fromRGBO(106, 97, 241, 0.3),
                    offset: Offset(0.0, 0.3), //(x,y)
                    blurRadius: 38.0,
                  ),
                ],
                borderRadius: BorderRadius.all(
                  Radius.circular(27.r),
                ),
              ),
              child: const Icon(Icons.person),
            ),
            Positioned(
              right: 0,
              child: Container(
                height: 25.h,
                width: 25.h,
                decoration: const BoxDecoration(
                    color: Color(0xFF858585), shape: BoxShape.circle),
                child: Icon(
                  Icons.edit,
                  color: Colors.white,
                  size: 20.r,
                ),
              ),
            )
          ],
        ),
        SizedBox(
          height: 20.h,
        ),
        Text(
          "Ayyyushhhhh",
          style: TextStyle(fontSize: 24.sp, fontWeight: FontWeight.w600),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
