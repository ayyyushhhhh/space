import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:space/models/To%20Do/to_do_model.dart';
import 'package:space/utils/ui_colors.dart';

class TodoDetailsWidget extends StatelessWidget {
  final ToDoModel toDoModel;
  const TodoDetailsWidget({super.key, required this.toDoModel});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          toDoModel.title,
          style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.w600,
              decoration: toDoModel.isDone
                  ? TextDecoration.lineThrough
                  : TextDecoration.none),
        ),
        if (!toDoModel.isDone)
          Container(
            height: 20.h,
            width: 20.w,
            decoration: const BoxDecoration(
                color: Color(0xFFD9D9D9), shape: BoxShape.circle),
          ),
        if (toDoModel.isDone)
          Container(
            height: 20.h,
            width: 20.w,
            decoration: const BoxDecoration(
                color: kTodoPrimaryColor, shape: BoxShape.circle),
            child: Center(
              child: Container(
                height: 12.h,
                width: 12.w,
                decoration: const BoxDecoration(
                    color: Color(0xFFFFB47E), shape: BoxShape.circle),
                child: Center(
                  child: Container(
                    height: 4.h,
                    width: 4.w,
                    decoration: const BoxDecoration(
                        color: Colors.white, shape: BoxShape.circle),
                  ),
                ),
              ),
            ),
          ),
      ],
    );
  }
}
