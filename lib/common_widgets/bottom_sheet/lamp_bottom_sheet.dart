import 'package:flutter/material.dart';


class Lamp_CustomModalSheet extends StatelessWidget {
  const Lamp_CustomModalSheet({
    this.height = 512,
    this.onClosePressed,
    this.title = '',
    required this.bottomWidget,
    this.widgetKey,
    this.bodyWidget,
    this.topIcon,
    this.shouldUseHeight = true,
  });

  final Key? widgetKey;
  final double height;
  final Function? onClosePressed;
  final String title;
  final Widget? bottomWidget;
  final Widget? bodyWidget;
  final Widget? topIcon;
  final bool shouldUseHeight;

  @override
  Widget build(BuildContext context) {
    return Container(
      key: widgetKey,
      height: shouldUseHeight ? height : null,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Container(
            margin: const EdgeInsets.only(top: 20),
            padding: const EdgeInsets.only(right: 20),
            alignment: Alignment.centerRight,
            child: GestureDetector(
              child: const Icon(
                Icons.close,
                size: 25,
                color: Color.fromRGBO(177, 177, 177, 1),
              ),
              onTap: () => onClosePressed!(),
            ),
          ),
          const SizedBox(height: 10),
          if (topIcon != null)
            Container(
              margin: const EdgeInsets.only(bottom: 10),
              child: topIcon!,
            ),
          if (title.isNotEmpty) Text(title, textAlign: TextAlign.center, style: Theme.of(context).textTheme.headline5!.copyWith(fontSize: 20)) else const SizedBox(),
          const SizedBox(height: 15),
          if (bodyWidget != null)
            Expanded(
              child: bodyWidget!,
            ),
          const SizedBox(height: 28),
          bottomWidget!,
          const SizedBox(height: 28),
        ],
      ),
    );
  }
}
