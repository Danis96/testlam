import 'package:flutter/material.dart';

/// NUMBER OF DOTS

class CustomIndicator extends StatelessWidget {
  const CustomIndicator({
    this.currentIndex = 0,
    this.numberOfDots = 0,
    this.selectedColor = const Color.fromRGBO(0, 18, 114, 1),
    this.unselectedColor = const Color.fromRGBO(197, 232, 231, 1),
  });

  final int currentIndex;
  final int numberOfDots;
  final Color selectedColor;
  final Color unselectedColor;

  @override
  Widget build(BuildContext context) {
    final List<Widget> dots = <Widget>[];
    for (int i = 0; i < numberOfDots; i++) {
      dots.add(Container(
        height: 5,
        width: 5,
        decoration: BoxDecoration(
          color: i == currentIndex ? selectedColor : unselectedColor,
          borderRadius: BorderRadius.circular(100),
        ),
      ));
      if (i < numberOfDots - 1) {
        dots.add(const SizedBox(width: 8));
      }
    }
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: dots,
    );
  }
}
