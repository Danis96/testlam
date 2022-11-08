import 'package:flutter/material.dart';

class Lamp_Button extends StatelessWidget {
  const Lamp_Button({Key? key, this.buttonTitle = '', this.disabled = false, @required this.onPressed, this.style, this.btnTitleStyle})
      : super(key: key);

  final String buttonTitle;
  final bool disabled;
  final Function? onPressed;
  final ButtonStyle? style;
  final TextStyle? btnTitleStyle;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      key: key,
      onPressed: disabled
          ? null
          : () {
              if (onPressed != null) {
                onPressed!();
              }
            },
      style: style,
      child: Padding(
          padding: const EdgeInsets.all(5),
          child: Text(buttonTitle,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
              style: btnTitleStyle ?? const TextStyle(
                color: Color.fromRGBO(63, 71, 67, 1),
                fontSize: 20.0,
                fontFamily: 'Ubuntu',
                fontWeight: FontWeight.w500,
              ))),
    );
  }
}
