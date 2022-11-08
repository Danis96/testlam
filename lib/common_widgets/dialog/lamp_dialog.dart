import 'dart:ui';

import 'package:flutter/material.dart';

import '../buttons/button.dart';

void Lamp_SimpleDialog(
    BuildContext context, {
      String title = '',
      String content = '',
      String buttonText = '',
      String buttonTwoText = '',
      Color titleColor = Colors.black,
      Color contentColor = Colors.black,
      Color buttonColor = Colors.black,
      String key = '',
      Widget? contentWidget,
      Widget? titleWidget,
      Function? onButtonPressed,
      Function? onButtonTwoPressed,
      bool dismiss = true,
      bool twoButtons = false,
      bool canPop = true,
    }) {
  showDialog(
    barrierDismissible: dismiss,
    context: context,
    builder: (_) => BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
      child: WillPopScope(
        onWillPop: () async {
          return canPop;
        },
        child: AlertDialog(
          shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(20.0))),
          key: Key(key),
          title: titleWidget ?? (Text(title, style: TextStyle(fontSize: 16.0, color: titleColor, fontWeight: FontWeight.bold))),
          content: contentWidget ??
              Text(content, textAlign: TextAlign.center, style: TextStyle(fontSize: 15.0, color: titleColor, fontWeight: FontWeight.w300)),
          actions: <Widget>[
            Container(
                height: 40,
                child: buttonTwoText.isEmpty
                    ? _buildOneButton(context, onPressed: onButtonPressed, title: buttonText)
                    : _buildTwoButtons(context,
                    buttonText: buttonText, buttonTwoText: buttonTwoText, onPressed: onButtonPressed, onButtonTwoPressed: onButtonTwoPressed)),
          ],
        ),
      ),
    ),
  );
}

Widget _buildOneButton(BuildContext context, {Function? onPressed, String title = ''}) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: <Widget>[
      Expanded(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Lamp_Button(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Colors.white),
              foregroundColor: MaterialStateProperty.all(Colors.black),
            ),
            onPressed: () {
              if (onPressed != null) {
                onPressed();
              } else {
                Navigator.of(context).pop();
              }
            },
            buttonTitle: title,
          ),
        ),
      )
    ],
  );
}

Widget _buildTwoButtons(
    BuildContext context, {
      Function? onPressed,
      String buttonText = '',
      Function? onButtonTwoPressed,
      String buttonTwoText = '',
      Color titleColor = Colors.black,
    }) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: <Widget>[
      TextButton(
        onPressed: () {
          if (onPressed != null) {
            onPressed();
          } else {
            Navigator.of(context).pop();
          }
        },
        child: Text(
          buttonText,
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 16.0, color: titleColor),
        ),
      ),
      TextButton(
        onPressed: () {
          if (onButtonTwoPressed != null) {
            onButtonTwoPressed();
          } else {
            Navigator.of(context).pop();
          }
        },
        child: Text(
          buttonTwoText,
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 16.0, color: titleColor),
        ),
      )
    ],
  );
}
