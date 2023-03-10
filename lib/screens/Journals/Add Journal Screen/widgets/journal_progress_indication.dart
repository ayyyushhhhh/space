import 'package:flutter/material.dart';

class JournalProgressIndicator extends StatelessWidget {
  final int value;
  final int currentVal;
  final double width;
  final double height;
  const JournalProgressIndicator(
      {super.key,
      required this.value,
      required this.width,
      required this.height,
      required this.currentVal});

  Widget _buildProgressContainer(int index) {
    double topLeft = 20;
    double topRight = 20;
    double bottomLeft = 20;
    double bottomRight = 20;
    if (index == 0) {
      topLeft = 20;
      topRight = 20;
      bottomLeft = 20;
      bottomRight = 20;
    } else if (index <= 1) {
      topLeft = 0;
      topRight = 20;
      bottomLeft = 0;
      bottomRight = 20;
    } else if (index <= 2) {
      topLeft = 0;
      topRight = 20;
      bottomLeft = 0;
      bottomRight = 20;
    }
    return Container(
      width: width / value,
      height: height,
      decoration: BoxDecoration(
        color: const Color(0xFF5349DB),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(topLeft),
          topRight: Radius.circular(topRight),
          bottomLeft: Radius.circular(bottomLeft),
          bottomRight: Radius.circular(bottomRight),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      decoration: const BoxDecoration(
        color: Color(0xFFD9D9D9),
        borderRadius: BorderRadius.all(
          Radius.circular(20),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          for (int i = 0; i < currentVal; i++) _buildProgressContainer(i),
        ],
      ),
    );
  }
}
