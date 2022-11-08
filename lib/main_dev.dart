import 'package:flutter/cupertino.dart';
import 'app/config/flavor_config.dart';
import 'main_common.dart';

//'https://lampicadev-apimobile.azurewebsites.net' test
// https://lampicatest-apimobile.azurewebsites.net prod


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  FlavorConfig(flavor: Flavor.DEV, values: FlavorValues(baseUrl: 'https://lampicatest-apimobile.azurewebsites.net', appName: 'Lampica'));
  mainCommon();
}
