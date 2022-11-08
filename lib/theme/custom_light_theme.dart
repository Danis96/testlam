import 'package:flutter/material.dart';

import 'color_helper.dart';

class CustomTheme {
  ThemeMode get currentTheme => ThemeMode.light;

  static ThemeData get lightTheme {
    return ThemeData(
      appBarTheme: AppBarTheme(
        color: ColorHelper.lampGray.color,
        elevation: 0,
        centerTitle: true,
        toolbarTextStyle: TextStyle(fontWeight: FontWeight.w700, fontSize: 18, color: ColorHelper.white.color),
      ),
      fontFamily: 'Ubuntu',
      primaryColor: ColorHelper.black.color,
      backgroundColor: ColorHelper.white.color,
      scaffoldBackgroundColor: ColorHelper.white.color,
      textTheme: TextTheme(
        headline1: TextStyle(fontSize: 32, fontWeight: FontWeight.w400, color: ColorHelper.lampGray.color),
        // list item title
        headline2: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w400, color: ColorHelper.lampGray.color),
        // smaller list item title
        headline3: TextStyle(fontSize: 16, fontWeight: FontWeight.w300, color: ColorHelper.lampGray.color),
        // italic
        headline4: TextStyle(fontSize: 20, fontWeight: FontWeight.w500, color: ColorHelper.lampGray.color, fontStyle: FontStyle.italic),
        // regular
        headline5: TextStyle(color: ColorHelper.lampGray.color, fontSize: 16, fontWeight: FontWeight.w400),
        headline6: TextStyle(fontWeight: FontWeight.w500, fontSize: 16, color: ColorHelper.lampGray.color),
        // error
        subtitle1: TextStyle(fontSize: 16, fontWeight: FontWeight.w400, color: ColorHelper.lampRed.color),
        subtitle2: TextStyle(color: ColorHelper.lampGray.color, fontSize: 14, fontWeight: FontWeight.w400),
        bodyText1: TextStyle(fontSize: 24, fontWeight: FontWeight.w400, color: ColorHelper.lampGray.color),
        //italic
        bodyText2: TextStyle(fontSize: 24, fontWeight: FontWeight.w700, color: ColorHelper.black.color, fontStyle: FontStyle.italic),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.resolveWith<Color>(
            (Set<MaterialState> states) {
              if (states.contains(MaterialState.disabled)) {
                return Colors.transparent;
              }
              return ColorHelper.lampGreen.color;
            },
          ),
          side: MaterialStateProperty.resolveWith<BorderSide>(
            (Set<MaterialState> states) {
              if (states.contains(MaterialState.disabled)) {
                return BorderSide(color: ColorHelper.lampGreen.color.withOpacity(0.2), width: 1);
              }
              return const BorderSide(color: Colors.transparent);
            },
          ),
          foregroundColor: MaterialStateProperty.resolveWith<Color>(
            (Set<MaterialState> states) {
              if (states.contains(MaterialState.disabled)) {
                return ColorHelper.lampGreen.color.withOpacity(0.2);
              }
              return ColorHelper.black.color;
            },
          ),
          elevation: MaterialStateProperty.all(0),
          shape: MaterialStateProperty.resolveWith<RoundedRectangleBorder>((Set<MaterialState> states) {
            if (states.contains(MaterialState.disabled)) {
              return RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0));
            }
            return RoundedRectangleBorder(borderRadius: BorderRadius.circular(15));
          }),
          minimumSize: MaterialStateProperty.all(const Size(400, 45)),
          padding: MaterialStateProperty.all(EdgeInsets.zero),
          textStyle: MaterialStateProperty.resolveWith<TextStyle>(
            (Set<MaterialState> states) {
              return TextStyle(
                color: Color.fromRGBO(63, 71, 67, 1),
                fontSize: 20.0,
                fontFamily: 'Ubuntu',
                fontWeight: FontWeight.w500,
              );
            },
          ),
        ),
      ),
      dividerTheme: DividerThemeData(thickness: 1, color: ColorHelper.white.color),
      cardTheme: CardTheme(
        elevation: 2,
        color: ColorHelper.white.color,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        shadowColor: ColorHelper.lampLightGray.color,
      ),
      inputDecorationTheme: InputDecorationTheme(
          labelStyle: TextStyle(color: ColorHelper.lampGray.color, fontSize: 28.0, height: 1.7, fontWeight: FontWeight.w500),
          floatingLabelBehavior: FloatingLabelBehavior.auto,
          // alignLabelWithHint: true,
          filled: true,
          focusColor: ColorHelper.lampLightGray.color,
          // fillColor: ColorHelper.lampLightGray.color,
          focusedBorder:
              const OutlineInputBorder(borderSide: BorderSide(color: Colors.transparent), borderRadius: BorderRadius.all(Radius.circular(15.0))),
          isDense: true,
          // contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 21),
          enabledBorder:
              const OutlineInputBorder(borderSide: BorderSide(color: Colors.transparent), borderRadius: BorderRadius.all(Radius.circular(15.0))),
          focusedErrorBorder:
              const OutlineInputBorder(borderSide: BorderSide(color: Colors.transparent), borderRadius: BorderRadius.all(Radius.circular(15.0))),
          errorBorder:
              const OutlineInputBorder(borderSide: BorderSide(color: Colors.transparent), borderRadius: BorderRadius.all(Radius.circular(15.0)))),
    );
  }
}
