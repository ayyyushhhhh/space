import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:space/models/To%20Do/to_do_model.dart';
import 'package:space/provider/ToDo/to_do_provider.dart';
import 'package:space/screens/To%20Do%20Screen/widgets/to_do_detail_widget.dart';
import 'package:space/utils/ui_colors.dart';

class ToDoContainerWidget extends StatelessWidget {
  const ToDoContainerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text.rich(
          TextSpan(
            children: [
              TextSpan(
                  text: 'My Daily ',
                  style:
                      TextStyle(fontSize: 24.sp, fontWeight: FontWeight.w600)),
              TextSpan(
                text: 'Task',
                style: TextStyle(
                    fontSize: 24.sp,
                    fontWeight: FontWeight.w600,
                    color: kTodoPrimaryColor),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 18.h,
        ),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(20),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(
              Radius.circular(20),
            ),
            boxShadow: [
              BoxShadow(
                color: Color.fromRGBO(0, 0, 0, 0.25),
                offset: Offset(0.0, 4), //(x,y)
                blurRadius: 38.0,
              ),
            ],
          ),
          child: Consumer<TodoProvider>(
            builder: (BuildContext context, value, Widget? child) {
              return SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                              text: 'I will accomplish ',
                              style: TextStyle(
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w600)),
                          TextSpan(
                            text: value.getTasks().toString(),
                            style: TextStyle(
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w700,
                                color: kTodoPrimaryColor),
                          ),
                          TextSpan(
                              text: ' task(s) today.',
                              style: TextStyle(
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w600)),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 12.h,
                    ),
                    Divider(thickness: 5.h, color: kTodoPrimaryColor),
                    ListView.builder(
                      padding: EdgeInsets.zero,
                      shrinkWrap: true,
                      itemCount: value.toDolist.length,
                      itemBuilder: (BuildContext context, int index) {
                        return InkWell(
                          onTap: () {
                            value.updateTodo(
                                index: index,
                                toDoModel: value.toDolist[index]
                                    .copyWith(isDone: true));
                          },
                          child: TodoDetailsWidget(
                              toDoModel: value.toDolist[index]),
                        );
                      },
                    ),
                    if (value.isAdding == true)
                      TextField(
                        controller: value.todoTextEditingController,
                        autofocus: value.isAdding,
                      ),
                    Center(
                      child: InkWell(
                        onTap: () {
                          if (value.isAdding == true &&
                              value.todoTextEditingController.text == "") {
                            value.updateIsAdding(false);
                          } else if (value.isAdding == true) {
                            ToDoModel toDoModel = ToDoModel(
                                title: value.todoTextEditingController.text,
                                isDone: false);
                            value.addToDo(toDoModel);
                            value.updateIsAdding(false);
                          } else {
                            value.updateIsAdding(true);
                          }
                        },
                        child: Container(
                          padding: const EdgeInsets.all(10),
                          margin: const EdgeInsets.all(10),
                          width: 240.w,
                          height: 40.h,
                          decoration: BoxDecoration(
                            color: kTodoPrimaryColor,
                            borderRadius: BorderRadius.circular(40),
                          ),
                          child: Center(
                            child: Text(
                              !value.isAdding ? "Add Task" : "Save Task",
                              style: TextStyle(
                                fontSize: 13.sp,
                                color: Colors.white,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
