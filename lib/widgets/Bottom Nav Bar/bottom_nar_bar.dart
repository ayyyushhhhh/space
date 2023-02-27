import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:space/utils/constants.dart';
import 'package:space/widgets/Bottom%20Nav%20Bar/bottom_nav_bar_widget.dart';

class BottomRoundedNavBar extends StatelessWidget {
  final List<BottomNavBarWidget> items;
  final int currentIndex;
  final Function(int index) onChanged;
  final double height;
  const BottomRoundedNavBar(
      {super.key,
      required this.items,
      required this.currentIndex,
      required this.onChanged,
      this.height = 80});

  Color _buildColor(int index, BuildContext context) {
    if (index == currentIndex) {
      return Colors.white;
    }

    return Colors.black;
  }

  Widget _buildBottomNavbarWidget(int index, BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Icon(
          items[index].iconData,
          color: _buildColor(index, context),
          size: items[index].iconSize,
        ),
        Text(
          items[index].label,
          style: TextStyle(
            color: _buildColor(index, context),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height.h,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: getBottomNavBarColorbyTheme(context),
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          for (int i = 0; i < items.length; i++)
            GestureDetector(
              onTap: () {
                onChanged(i);
              },
              child: Container(
                decoration: BoxDecoration(
                  color: i == currentIndex ? kPrimaryColor : Colors.transparent,
                  shape: BoxShape.rectangle,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                    bottomLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30),
                  ),
                ),
                padding: const EdgeInsets.symmetric(
                    horizontal: 10.0, vertical: 10.0),
                child: _buildBottomNavbarWidget(i, context),
              ),
            )
        ],
      ),
    );
  }
}
