import 'package:flutter/material.dart';
import 'package:lamp/app/utils/string_texts.dart';
import 'package:lamp/common_widgets/buttons/button.dart';
import 'package:lamp/common_widgets/dialog/lamp_dialog.dart';
import 'package:lamp/common_widgets/loader/lamp_loader.dart';
import 'package:provider/provider.dart';

import '../../../common_widgets/app_bar/app_bar.dart';
import '../../../theme/color_helper.dart';
import '../../models/article_model.dart';
import '../../models/articles_model.dart';
import '../../providers/articles_provider/articles_provider.dart';

class ArticlesBuyPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: _buildAppBar(context), body: _buildBody(context));
  }
}

PreferredSizeWidget _buildAppBar(BuildContext context) {
  return Lamp_AppBarIconTitleIcon(
    context,
    onActionPressed: null,
    implyAction: false,
    centerTitle: true,
    onLeadingPressed: () => Navigator.of(context).pop(),
    leadingIcon: Icons.arrow_back_ios,
    leadingIconColor: ColorHelper.lampGray.color,
  );
}

Widget _buildBody(BuildContext context) {
  final ArticleModel a = context.read<ArticlesProvider>().articleDetail;
  return ListView(
    padding: const EdgeInsets.symmetric(horizontal: 18),
    shrinkWrap: true,
    children: <Widget>[
      _returnArticleCard(context, a),
      const SizedBox(height: 40),
      _buyButton(context),
      const SizedBox(height: 20),
      _giveUpButton(context),
      const SizedBox(height: 40),
      context.watch<ArticlesProvider>().showSuccess ? _buildSuccessWidget(context) : _returnInfo(context),
    ],
  );
}

Widget _buyButton(BuildContext context) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 24),
    child: Lamp_Button(
        onPressed: () {
          Lamp_LoaderCircleWhite(context: context);
          context.read<ArticlesProvider>().buyAward().then((String? error) {
            Navigator.of(context).pop();
            if (error != null) {
              context.read<ArticlesProvider>().setShowSuccess(false);
              Lamp_SimpleDialog(context, title: common_greska_error, content: error, buttonText: common_btn_ok, onButtonPressed: () => Navigator.of(context).pop());
            } else {
              context.read<ArticlesProvider>().setShowSuccess(true);
            }
          });
        },
        buttonTitle: 'Kupi'),
  );
}

Widget _giveUpButton(BuildContext context) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 24),
    child: Lamp_Button(
      onPressed: () => Navigator.of(context).pop(),
      buttonTitle: 'Odustani',
      style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(ColorHelper.lampGray.color),
          foregroundColor: MaterialStateProperty.all<Color>(ColorHelper.white.color)),
    ),
  );
}

Widget _returnInfo(BuildContext context) {
  return Card(
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: RichText(
        textAlign: TextAlign.center,
        text: TextSpan(
          children: <TextSpan>[
            TextSpan(
                text:
                    'Lampica korisnička podrška će Vas kontaktirati radi potvrde ispravnosti podataka za dostavu, a ukoliko nešto od podataka nedostaje molimo Vas da pozovete ',
                style: Theme.of(context).textTheme.headline3),
            TextSpan(text: 'besplatan', style: Theme.of(context).textTheme.headline3!.copyWith(fontWeight: FontWeight.w600)),
            TextSpan(text: ' info broj ', style: Theme.of(context).textTheme.headline3),
            TextSpan(text: '080/030-555.', style: Theme.of(context).textTheme.headline3!.copyWith(fontWeight: FontWeight.w600)),
          ],
        ),
      ),
    ),
  );
}

Widget _buildSuccessWidget(BuildContext context) {
  return Card(
    child: Container(
      height: 203,
      padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          Image.asset('assets/ic_success.png', width: 48),
          Text('Kupovina je uspješno izvršena!', style: Theme.of(context).textTheme.headline4!.copyWith(fontStyle: FontStyle.normal)),
        ],
      ),
    ),
  );
}

Widget _returnArticleCard(BuildContext context, ArticleModel a) {
  return Card(
    child: Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(11),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(a.name, style: Theme.of(context).textTheme.headline2!.copyWith(fontWeight: FontWeight.w500)),
              ],
            ),
          ),
          const SizedBox(height: 20),
          Row(
            children: <Widget>[
              Image.asset('assets/lampica_logo.png', height: 50, width: 50),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text('${a.creditAmount} b', style: Theme.of(context).textTheme.headline2!.copyWith(fontWeight: FontWeight.w500, fontSize: 16)),
                  Text('${a.priceAmount} km', style: Theme.of(context).textTheme.headline2!.copyWith(fontWeight: FontWeight.w500, fontSize: 16)),
                ],
              ),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            children: <Widget>[
              Image.asset('assets/location.png', height: 40, width: 50),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text('Adresa', style: Theme.of(context).textTheme.headline2!.copyWith(fontWeight: FontWeight.w500, fontSize: 16)),
                  Text(a.address, style: Theme.of(context).textTheme.headline2!.copyWith(fontWeight: FontWeight.w500, fontSize: 16)),
                ],
              ),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            children: <Widget>[
              Image.asset('assets/mobile.png', height: 50, width: 50),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text('Broj telefona', style: Theme.of(context).textTheme.headline2!.copyWith(fontWeight: FontWeight.w500, fontSize: 16)),
                  Text(a.phoneNumber, style: Theme.of(context).textTheme.headline2!.copyWith(fontWeight: FontWeight.w500, fontSize: 16)),
                ],
              ),
            ],
          ),
        ],
      ),
    ),
  );
}
