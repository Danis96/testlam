import 'package:get_it/get_it.dart';
import 'package:lamp/app/repositories/navigation_repo.dart';

GetIt locator = GetIt.instance;

void setupLocator() {
  locator.registerLazySingleton(() => NavigationRepo());
}
