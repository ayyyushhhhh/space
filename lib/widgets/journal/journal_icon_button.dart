import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class JournalIconButton extends StatelessWidget {
  final VoidCallback onPressed;
  const JournalIconButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 35.h,
      margin: const EdgeInsets.all(5),
      width: 35.w,
      decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(10)),
      child: IconButton(
        padding: EdgeInsets.zero,
        onPressed: onPressed,
        icon: Icon(
          Icons.done,
          size: 30.r,
        ),
      ),
    );
  }
}
