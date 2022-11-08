import 'dart:ui';

import 'package:flutter/material.dart';

enum ColorHelper {
  white,
  black,
  lampGreen,
  lampGray,
  lampRed,
  lampLightGray,
  lampDarkGray,
}

extension ColorExtension on ColorHelper {
  Color get color {
    switch (this) {
      case ColorHelper.white:
        return const Color.fromRGBO(255, 255, 255, 1);
      case ColorHelper.black:
        return const Color.fromRGBO(0, 0, 0, 1);
      case ColorHelper.lampGreen:
        return const Color.fromRGBO(193, 215, 46, 1);
      case ColorHelper.lampGray:
        return const Color.fromRGBO(63, 71, 67, 1);
      case ColorHelper.lampLightGray:
        return const Color.fromRGBO(217, 220, 198, 1);
      case ColorHelper.lampDarkGray:
        return const Color.fromRGBO(84, 86, 91, 1);
      case ColorHelper.lampRed:
        return const Color.fromRGBO(214, 76, 46, 1);
      default:
        return Colors.white;
    }
  }
}
