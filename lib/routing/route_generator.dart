import 'package:flutter/material.dart';
import 'package:lamp/app/providers/account_provider/account_provider.dart';
import 'package:lamp/app/providers/articles_provider/articles_provider.dart';
import 'package:lamp/app/providers/auth_provider/auth_provider.dart';
import 'package:lamp/app/providers/donation_provider/donation_provider.dart';
import 'package:lamp/app/providers/dopuna_provider/dopuna_provider.dart';
import 'package:lamp/app/providers/news_provider/news_provider.dart';
import 'package:lamp/app/providers/promo_code_provider/promo_code_provider.dart';
import 'package:lamp/app/providers/report_provider/report_provider.dart';
import 'package:lamp/app/providers/sales_location_provider/sales_location_provider.dart';
import 'package:lamp/app/providers/screen_brightness_provider/screen_brightness_provider.dart';
import 'package:lamp/app/providers/send_points_provider/send_points_provider.dart';
import 'package:lamp/app/view/articles/articles_buy_page.dart';
import 'package:lamp/app/view/articles/articles_details.dart';
import 'package:lamp/app/view/articles/articles_page.dart';
import 'package:lamp/app/view/bottom_navigation/bottom_navigation.dart';
import 'package:lamp/app/view/change_password/change_password.dart';
import 'package:lamp/app/view/dopuna/dopuna_page.dart';
import 'package:lamp/app/view/izvjestaji/izvjestaji_page.dart';
import 'package:lamp/app/view/karticapage/kartica_page.dart';
import 'package:lamp/app/view/notifications/notification_details_page.dart';
import 'package:lamp/app/view/notifications/notifications_page.dart';
import 'package:lamp/app/view/poklon_bodovi/pokloni_bodove.dart';
import 'package:lamp/app/view/pomozi_ba/pomozi_ba.dart';
import 'package:lamp/app/view/news/news_details_page.dart';
import 'package:lamp/app/view/prodajna_mjesta/prodajna_mjesta_detalji.dart';
import 'package:lamp/app/view/promo_code/promo_code.dart';
import 'package:lamp/app/view/registration/registration_page.dart';
import 'package:lamp/routing/routes.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import '../app/providers/splash_provider/splash_provider.dart';
import '../app/utils/navigation_animation.dart';
import '../app/view/splash/splash_page.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case splash:
        return SlideAnimationTween(widget: Provider<SplashProvider>(create: (_) => SplashProvider(), lazy: false, child: SplashPage()));
      case registration:
        return SlideAnimationTween(widget: ChangeNotifierProvider<AuthProvider>(create: (_) => AuthProvider(), child: RegistrationPage()));
      case bottomNavigation:
        return SlideAnimationTween(
            widget: MultiProvider(
          providers: <SingleChildWidget>[
            ChangeNotifierProvider<AccountProvider>(create: (_) => AccountProvider()),
            ChangeNotifierProvider<NewsProvider>(create: (_) => NewsProvider()),
            ChangeNotifierProvider<AuthProvider>(create: (_) => AuthProvider()),
            ChangeNotifierProvider<SalesLocationProvider>(create: (_) => SalesLocationProvider()),
            ChangeNotifierProvider<ScreenBrightnessProvider>(create: (_) => ScreenBrightnessProvider()),
            ChangeNotifierProvider<ReportProvider>(create: (_) => ReportProvider()),
          ],
          child: BottomNavigationPage(),
        ));
      case dopuna:
        return SlideAnimationTween(widget: ChangeNotifierProvider<DopunaProvider>(create: (_) => DopunaProvider(), child: DopunaPage()));
      case kartica:
        return SlideAnimationTween(widget: KarticaPage());
      case izvjestaji:
        return SlideAnimationTween(widget: IzvjestajiPage());
      case pokloniBodove:
        return SlideAnimationTween(widget: ChangeNotifierProvider<SendPointsProvider>(create: (_) => SendPointsProvider(), child: PokloniBodove()));
      case pomoziBa:
        return SlideAnimationTween(
            widget: MultiProvider(
          providers: [
            ChangeNotifierProvider<DonationProvider>(create: (_) => DonationProvider()),
            ChangeNotifierProvider<AccountProvider>(create: (_) => AccountProvider()),
          ],
          child: PomoziBa(),
        ));
      case changePassword:
        return SlideAnimationTween(
            widget: ChangeNotifierProvider<AuthProvider>.value(value: settings.arguments as AuthProvider, child: ChangePassword()));
      case newsDetails:
        return SlideAnimationTween(
            widget: ChangeNotifierProvider<NewsProvider>.value(value: settings.arguments as NewsProvider, child: NewsDetailsPage()));
      case prodajnaMjestaDetalji:
        return SlideAnimationTween(
            widget: ChangeNotifierProvider<SalesLocationProvider>.value(
                value: settings.arguments as SalesLocationProvider, child: ProdajnaMjestaDetaljiPage()));
      case notifications:
        return SlideAnimationTween(
            widget: ChangeNotifierProvider<AccountProvider>.value(value: settings.arguments as AccountProvider, child: NotificationsPage()));
      case notificationDetails:
        return SlideAnimationTween(
            widget: ChangeNotifierProvider<AccountProvider>.value(value: settings.arguments as AccountProvider, child: NotificationDetailsPage()));
      case promoCode:
        return SlideAnimationTween(widget: ChangeNotifierProvider<PromoCodeProvider>(create: (_) => PromoCodeProvider(), child: PromoCodePage()));
      case articles:
        return SlideAnimationTween(widget: ChangeNotifierProvider<ArticlesProvider>(create: (_) => ArticlesProvider(), child: ArticlesPage()));
      case articleDetails:
        return SlideAnimationTween(
            widget: ChangeNotifierProvider<ArticlesProvider>.value(value: settings.arguments as ArticlesProvider, child: ArticlesDetailsPage()));
      case articleBuy:
        return SlideAnimationTween(
            widget: ChangeNotifierProvider<ArticlesProvider>.value(value: settings.arguments as ArticlesProvider, child: ArticlesBuyPage()));
      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute<void>(builder: (_) {
      return Scaffold(
        appBar: AppBar(title: const Text('Error')),
        body: const Center(
          child: Text('Error Screen'),
        ),
      );
    });
  }
}
