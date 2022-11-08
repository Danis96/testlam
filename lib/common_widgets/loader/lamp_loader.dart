import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../../theme/color_helper.dart';

Future<void> Lamp_LoaderCircleWhite({
  @required BuildContext? context,
}) {
  return showMyDialog(
    msg: '',
    action: const SizedBox(),
    context: context,
    barrier: false,
    title: '',
    mainWidget: SpinKitChasingDots(
      size: 50.0,
      color: ColorHelper.white.color,
    ),
    color: Colors.transparent,
    elevation: 0,
  );
}


Future<void> showMyDialog({
  BuildContext? context,
  String title = '',
  String msg = '',
  Color color = Colors.white,
  Widget? mainWidget,
  Widget? action,
  double elevation = 0,
  bool barrier = false,
}) async {
  return showDialog<void>(
    context: context!,
    barrierDismissible: barrier,
    builder: (BuildContext context) {
      return AlertDialog(
        elevation: 0,
        backgroundColor: color,
        title: Text(title),
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              Container(
                child: mainWidget ?? const SizedBox(),
              )
            ],
          ),
        ),
        actions: <Widget>[
          action ?? const SizedBox(),
        ],
      );
    },
  );
}