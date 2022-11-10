import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:lamp/app/repositories/navigation_repo.dart';
import 'package:month_year_picker/month_year_picker.dart';
import 'package:provider/provider.dart';

import '../routing/route_generator.dart';
import '../routing/routes.dart';
import '../theme/custom_light_theme.dart';
import '../theme/theme_config.dart';
import 'locator.dart';

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          final FocusScopeNode currentFocus = FocusScope.of(context);
          if (!currentFocus.hasPrimaryFocus && currentFocus.focusedChild != null) {
            FocusManager.instance.primaryFocus?.unfocus();
          }
        },
        child: buildApp(context));
  }
}

Widget buildApp(BuildContext ctx) {
  return MaterialApp(
    navigatorKey: locator<NavigationRepo>().navigationKey,
    builder: (BuildContext context, Widget? child) {
      final MediaQueryData data = MediaQuery.of(context);
      return MediaQuery(data: data.copyWith(textScaleFactor: 1.0), child: child!);
    },
    localizationsDelegates: const [
      GlobalWidgetsLocalizations.delegate,
      GlobalMaterialLocalizations.delegate,
      MonthYearPickerLocalizations.delegate,
    ],
    supportedLocales: [
      Locale('hr', 'HR'),
    ],
    initialRoute: splash,
    onGenerateRoute: RouteGenerator.generateRoute,
    debugShowCheckedModeBanner: false,
    title: 'Lampica',
    theme: CustomTheme.lightTheme,
    themeMode: currentTheme.currentTheme,
  );
}
