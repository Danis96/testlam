import 'dart:io';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lamp/app/providers/account_provider/account_provider.dart';
import 'package:lamp/app/providers/auth_provider/auth_provider.dart';
import 'package:lamp/app/utils/string_texts.dart';
import 'package:lamp/common_widgets/buttons/button.dart';
import 'package:lamp/common_widgets/dialog/lamp_dialog.dart';
import 'package:lamp/common_widgets/loader/lamp_loader.dart';
import 'package:provider/provider.dart';

import '../../../common_widgets/custom_carousel_indicator/custom_carousel_indicator.dart';
import '../../../routing/routes.dart';
import '../../../theme/color_helper.dart';

class Homepage extends StatefulWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Lamp_LoaderCircleWhite(context: context);
      _getInitialData().then((value) {
        Navigator.of(context).pop();
      });
    });
    super.initState();
  }

  Future<void> _getInitialData() async {
    await context.read<AccountProvider>().getUserMainInfo();
    await context.read<AccountProvider>().getUserNotifications();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WillPopScope(
          onWillPop: () async => false,
          child: SafeArea(child: _buildBody(context))),
    );
  }

  Widget _headlineText(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text('$home_pozdrav_part1${context.watch<AccountProvider>().userMainInfo.firstName}$home_pozdrav_part2',
              style: Theme.of(context).textTheme.headline4!.copyWith(fontSize: 16)),
          GestureDetector(
            onTap: () => Navigator.of(context).pushNamed(notifications, arguments: context.read<AccountProvider>()),
            child: Stack(
              children: [
                Icon(Icons.notifications, color: ColorHelper.lampGray.color),
                Positioned(
                  right: 3,
                  top: 1,
                  child: Container(
                    height: 6,
                    width: 6,
                    decoration: BoxDecoration(
                      color: context.watch<AccountProvider>().haveUnreadNotifications() ? ColorHelper.lampRed.color : ColorHelper.lampGray.color,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 27),
      shrinkWrap: true,
      children: <Widget>[
        _headlineText(context),
        _buildCarousel(context),
        CustomIndicator(
          currentIndex: context.watch<AccountProvider>().indexCarousel,
          numberOfDots: 3,
          selectedColor: ColorHelper.lampGreen.color,
          unselectedColor: ColorHelper.lampGray.color,
        ),
        const SizedBox(height: 5),
        _buildHomeMenuAndImgWidget(context),
        const SizedBox(height: 40),
      ],
    );
  }

  Widget _homePageSliderCard(BuildContext context, String image) {
    return SizedBox(width: MediaQuery.of(context).size.width, height: 199, child: Image.asset(image));
  }

  Widget _buildCarousel(BuildContext context) {
    return CarouselSlider(
      options: CarouselOptions(
          autoPlay: false,
          enableInfiniteScroll: false,
          viewportFraction: 1,
          scrollPhysics: const BouncingScrollPhysics(),
          onPageChanged: (int i, CarouselPageChangedReason carouselPageChangedReason) {
            context.read<AccountProvider>().addIndexCarousel(i);
          }),
      items: _carouselImages.map((i) {
        return _homePageSliderCard(context, i);
      }).toList(),
    );
  }

  Widget _buildHomeMenuAndImgWidget(BuildContext context) {
    return SizedBox(
      child: Stack(
        alignment: Alignment.topCenter,
        children: <Widget>[
          _returnMenu(context),
          _profileImg(context),
        ],
      ),
    );
  }

  Widget _profileImg(BuildContext context) {
    final AccountProvider accountProvider = Provider.of<AccountProvider>(context);
    return GestureDetector(
      onTap: () {
        Lamp_SimpleDialog(
          context,
          titleWidget: _lampTitleWidget(context, home_odaberi_sliku_title),
          buttonText: accountProvider.imageFile == null ? home_odaberi_sliku_btn : home_ukloni_sliku_btn,
          onButtonPressed: () {
            accountProvider.imageFile == null
                ? accountProvider.uploadImage(context).then((value) async {
                    await accountProvider.getUserMainInfo();
                    Navigator.of(context).pop();
                  })
                : accountProvider.deletePhoto(context).then((value) async {
                    await accountProvider.getUserMainInfo();
                    Navigator.of(context).pop();
                  });
          },
        );
      },
      child: SizedBox(
        width: Platform.isAndroid ? 100 : MediaQuery.of(context).size.width * 0.3,
        height: Platform.isAndroid ? 100 : MediaQuery.of(context).size.height * 0.14,
        child: context.watch<AccountProvider>().userPhoto != null
            ? ClipRRect(
                borderRadius: BorderRadius.circular(60),
                child: Image.network(
                  context.watch<AccountProvider>().userPhoto!,
                  fit: BoxFit.cover,
                  errorBuilder: (BuildContext s, Object a, StackTrace? w) {
                    return ClipRRect(borderRadius: BorderRadius.circular(60), child: Image.asset('assets/home_img.png', fit: BoxFit.cover));
                  },
                ),
              )
            : ClipRRect(borderRadius: BorderRadius.circular(60), child: Image.asset('assets/home_img.png', fit: BoxFit.cover)),
      ),
    );
  }

  Widget _lampTitleWidget(BuildContext context, String title) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Image.asset('assets/lampica_logo.png', width: 25),
        const SizedBox(width: 5),
        Text(title),
      ],
    );
  }

  Widget _returnMenu(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.06),
      decoration: BoxDecoration(
         border: Border.all(color: Color.fromRGBO(0, 0, 0, 0.1)),
        borderRadius: BorderRadius.circular(32),
      ),
      child: SizedBox(
        height: Platform.isAndroid ? MediaQuery.of(context).size.height / 1.2 : MediaQuery.of(context).size.height / 1.4,
        child: Column(
          children: <Widget>[
            Container(
                margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.08),
                child: Text(
                  context.watch<AccountProvider>().userMainInfo.fullName,
                  style: Theme.of(context).textTheme.bodyText1!.copyWith(fontWeight: FontWeight.w700, fontStyle: FontStyle.italic),
                )),
            const SizedBox(height: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                _statePointsWidget(context, home_stanje_bodova, context.read<AccountProvider>().userMainInfo.totalPointsAmount, isPoints: true),
                const SizedBox(width: 11),
                _statePointsWidget(context, home_stanje_km, context.read<AccountProvider>().userMainInfo.totalMoneyAmount.toInt()),
              ],
            ),
            const SizedBox(height: 12),
            _buildButtonList(context),
          ],
        ),
      ),
    );
  }

  Widget _statePointsWidget(BuildContext context, String title, int value, {bool isPoints = false}) {
    var formatter = NumberFormat('#,### 000');
    return Container(
      height: 73,
      width: 124,
      decoration: BoxDecoration(border: Border.all(color: ColorHelper.lampGreen.color), borderRadius: BorderRadius.circular(10)),
      child: Column(
        children: <Widget>[
          Container(
            height: 36,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              color: ColorHelper.lampGreen.color,
              borderRadius: const BorderRadius.only(topRight: Radius.circular(10), topLeft: Radius.circular(10)),
            ),
            child: Center(child: Text(title, style: Theme.of(context).textTheme.headline5!.copyWith(fontWeight: FontWeight.w500, fontSize: 16))),
          ),
          const SizedBox(height: 5),
          isPoints ?
          Text(formatter.format(value).replaceAll(',', ' '), style: Theme.of(context).textTheme.headline2!.copyWith(fontWeight: FontWeight.w700)) :
          Text(value.toString(), style: Theme.of(context).textTheme.headline2!.copyWith(fontWeight: FontWeight.w700)),
        ],
      ),
    );
  }

  Widget _buildButtonList(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: ListView(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        children: _btnHomeList
            .map((e) => Container(
                margin: const EdgeInsets.only(top: 10),
                child: Lamp_Button(
                    onPressed: () => e.logout
                        ? logoutDialog(context)
                        : Navigator.of(context).pushNamed(e.route).then((value) {
                            _getInitialData();
                          }),
                    buttonTitle: e.title)))
            .toList(),
      ),
    );
  }

  void logoutDialog(BuildContext context) {
    Lamp_SimpleDialog(
      context,
      titleWidget: _lampTitleWidget(context, odjava_title),
      content: odjava_subtitle,
      twoButtons: true,
      buttonText: odjava_btn_odjavi_se,
      buttonTwoText: odjava_btn_nazad,
      onButtonPressed: () {
        Lamp_LoaderCircleWhite(context: context);
        Future.delayed(
          const Duration(milliseconds: 1200),
          () {
            context.read<AuthProvider>().logout().then((String? error) {
              Navigator.of(context).pop();
              if (error != null) {
                Lamp_SimpleDialog(
                  context,
                  title: common_greska_error,
                  content: error,
                  buttonText: common_btn_ok,
                  onButtonPressed: () => Navigator.of(context).pop(),
                );
              } else {
                Navigator.of(context).pushNamedAndRemoveUntil(registration, (route) => false);
              }
            });
          },
        );
      },
      onButtonTwoPressed: () => Navigator.of(context).pop(),
    );
  }
}

List<String> _carouselImages = ['assets/home_slider1.png', 'assets/home_slider2.png', 'assets/home_slider3.png'];

List<BtnHomeModel> _btnHomeList = <BtnHomeModel>[
  BtnHomeModel(title: home_btn_artikli, route: articles),
  BtnHomeModel(title: home_btn_dopuna, route: dopuna),
  BtnHomeModel(title: home_btn_pokloni_bodove, route: pokloniBodove),
  BtnHomeModel(title: home_btn_pomozi, route: pomoziBa),
  BtnHomeModel(title: home_btn_promo, route: promoCode),
  BtnHomeModel(title: home_btn_odjava, route: '', logout: true),
];

class BtnHomeModel {
  BtnHomeModel({this.title = '', this.route = '', this.logout = false});

  String title;
  String route;
  bool logout;
}
