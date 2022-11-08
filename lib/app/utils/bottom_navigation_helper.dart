import 'package:lamp/app/view/homepage/home_page.dart';
import 'package:lamp/app/view/izvjestaji/izvjestaji_page.dart';
import 'package:lamp/app/view/karticapage/kartica_page.dart';
import 'package:lamp/app/view/news/news_page.dart';
import 'package:lamp/app/view/prodajna_mjesta/prodajna_mjesta_page.dart';
import 'package:lamp/common_widgets/bottom_navigation_bar/bottom_navigation_bar.dart';

class BottomNavigationHelper {
  List<Lamp_BottomNavigationItem> bottomNavigationItems() => <Lamp_BottomNavigationItem>[
        Lamp_BottomNavigationItem(title: '', icon: 'assets/ic_loc.png', page: const ProdajnaMjestapage()),
        Lamp_BottomNavigationItem(title: '', icon: 'assets/lamp_ottom.png', page: const NewsPage()),
        Lamp_BottomNavigationItem(title: '', icon: 'assets/ic_home.png', page: const Homepage()),
        Lamp_BottomNavigationItem(title: '', icon: 'assets/ic_graph.png', page: const IzvjestajiPage()),
        Lamp_BottomNavigationItem(title: '', icon: 'assets/ic_card.png', page: KarticaPage()),
      ];
}
