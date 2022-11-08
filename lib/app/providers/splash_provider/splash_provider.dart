import 'package:shared_preferences/shared_preferences.dart';

import '../../../routing/routes.dart';
import '../../locator.dart';
import '../../repositories/navigation_repo.dart';
import '../../utils/storage_prefs_manager.dart';

class SplashProvider {
  SplashProvider() {
    onInit();
  }

  final NavigationRepo _navigationService = locator<NavigationRepo>();

  Future<void> onInit() async {
    await Future<void>.delayed(const Duration(seconds: 1));
    final String userData = await storagePrefs.getValue(StoragePrefsManager.ACCESS_TOKEN);
    final bool logged = isUserLoggedIn(userData);
    if (logged) {
      _navigationService.navigateAndRemove(bottomNavigation);
    } else {
      _navigationService.navigateAndRemove(registration);
    }
  }

  bool isUserLoggedIn(String userData) {
    return userData != '';
  }
}
