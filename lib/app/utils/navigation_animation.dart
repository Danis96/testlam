import 'package:flutter/material.dart';

class SlideAnimationTween extends PageRouteBuilder<dynamic> {
  SlideAnimationTween({required this.widget})
      : super(
    pageBuilder: (BuildContext context, Animation<double> animation,
        Animation<double> secAnimation) {
      return widget;
    },
    transitionDuration: const Duration(milliseconds: 300),
    transitionsBuilder: (BuildContext context,
        Animation<double> animation,
        Animation<double> secAnimation,
        Widget child) {
      const Offset begin = Offset(1.0, 0.0);
      const Offset end = Offset.zero;
      const Cubic curve = Curves.ease;
      final Animatable<Offset> tween =
      Tween<Offset>(begin: begin, end: end)
          .chain(CurveTween(curve: curve));

      return SlideTransition(
        position: animation.drive(tween),
        child: child,
      );
    },
  );
  final Widget widget;
}
