import 'package:flutter/material.dart';
import 'package:lamp/theme/color_helper.dart';

class Lamp_InfoWidget extends StatelessWidget {
  Lamp_InfoWidget({this.title = '', this.subtitle = '', this.isError = false});

  final String title;
  final String subtitle;
  final bool isError;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        height: 150,
        width: 300,
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(title,
                style: Theme.of(context)
                    .textTheme
                    .subtitle1!
                    .copyWith(fontWeight: FontWeight.w500, color: isError ? ColorHelper.lampRed.color : ColorHelper.black.color)),
            const SizedBox(height: 20),
            Text(subtitle,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.subtitle1!.copyWith(color: isError ? ColorHelper.lampRed.color : ColorHelper.black.color)),
          ],
        ),
      ),
    );
  }
}
