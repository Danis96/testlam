import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'app/locator.dart';
import 'app/my_app.dart';
import 'app/utils/storage_prefs_manager.dart';

void mainCommon() {
  setupLocator();
  Future.wait<void>([storagePrefs.init()]).then((_) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
        .then((value) => runApp(MyApp()));
  });
}
