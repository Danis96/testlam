import 'package:flutter/material.dart';
import 'package:lamp/theme/color_helper.dart';
import '../../../common_widgets/bottom_navigation_bar/bottom_navigation_bar.dart';
import '../../utils/bottom_navigation_helper.dart';

class BottomNavigationPage extends StatelessWidget {
  final BottomNavigationHelper _navigationHelper = BottomNavigationHelper();

  @override
  Widget build(BuildContext context) {
    return Lamp_BottomNavigationPage(
      items: _navigationHelper.bottomNavigationItems(),
      widgetKey: const Key('bottom_navigation_page_key'),
      showTitle: false,
      initialSelection: 2,
      selectedItemColor: ColorHelper.lampGray.color,
      unSelectedItemColor: ColorHelper.lampGray.color,
    );
  }
}
