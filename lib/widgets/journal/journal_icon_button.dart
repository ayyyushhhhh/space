import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class JournalIconButton extends StatelessWidget {
  final VoidCallback onPressed;
  final IconData iconData;
  const JournalIconButton(
      {super.key, required this.onPressed, required this.iconData});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50.h,
      margin: const EdgeInsets.all(5),
      width: 50.w,
      decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(10)),
      child: IconButton(
        padding: EdgeInsets.zero,
        onPressed: onPressed,
        icon: Icon(
          iconData,
          size: 45.r,
        ),
      ),
    );
  }
}
