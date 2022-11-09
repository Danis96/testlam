import 'package:flutter/material.dart';
import 'package:lamp/app/models/dopuna_amount.dart';
import 'package:lamp/app/models/dopuna_mobile_operator.dart';
import 'package:lamp/app/providers/dopuna_provider/dopuna_provider.dart';
import 'package:lamp/app/providers/provider_constant.dart';
import 'package:lamp/app/utils/string_texts.dart';
import 'package:lamp/common_widgets/app_bar/app_bar.dart';
import 'package:lamp/common_widgets/dialog/lamp_dialog.dart';
import 'package:lamp/common_widgets/text_field/TextFieldType.dart';
import 'package:lamp/theme/color_helper.dart';
import 'package:provider/provider.dart';

import '../../../common_widgets/buttons/button.dart';
import '../../../common_widgets/loader/lamp_loader.dart';

class DopunaPage extends StatefulWidget {
  @override
  State<DopunaPage> createState() => _DopunaPageState();
}

class _DopunaPageState extends State<DopunaPage> {
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
    await context.read<DopunaProvider>().getMobileOperators();
    await context.read<DopunaProvider>().getRefillAmount();
  }

  bool openMobile = false;
  bool openAmount = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      body: _buildBody(context),
      bottomNavigationBar: _buildBottomButton(),
    );
  }

  Widget _buildBottomButton() {
    return (context.watch<DopunaProvider>().isAmountChosen() &&
            context.watch<DopunaProvider>().isMobileChosen() &&
            context.watch<DopunaProvider>().isPhoneNumberEmpty())
        ? Container(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 30),
            child: Lamp_Button(
                onPressed: () {
                  Lamp_LoaderCircleWhite(context: context);
                  context.read<DopunaProvider>().sendSmsTopUp().then((String? error) {
                    Navigator.of(context).pop();
                    if (error != null) {
                      context.read<DopunaProvider>().setDopunaSuccess(false);
                      Lamp_SimpleDialog(context, title: common_greska_error, buttonText: common_btn_ok, content: error);
                    } else {
                      context.read<DopunaProvider>().setDopunaSuccess(true);
                    }
                  });
                },
                buttonTitle: dopuna_btn_potvrdi))
        : const SizedBox();
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return Lamp_AppBarIconTitleIcon(
      context,
      onActionPressed: null,
      implyAction: false,
      onLeadingPressed: () => Navigator.of(context).pop(),
      title: dopuna_app_bar,
      centerTitle: false,
      leadingIcon: Icons.arrow_back_ios_new,
      leadingIconColor: ColorHelper.lampGray.color,
    );
  }

  Widget _buildBody(BuildContext context) {
    return ListView(padding: const EdgeInsets.symmetric(horizontal: 24), shrinkWrap: true, children: <Widget>[
      const SizedBox(height: 40),
      _buildImageHeader(context),
      const SizedBox(height: 20),
      context.watch<DopunaProvider>().isDopunaSuccess
          ? _buildSuccessWidget(context)
          : Column(
              children: <Widget>[
                _buildPhoneNumberField(context),
                const SizedBox(height: 20),
                _buildExpandableWidget(
                  context,
                  dopuna_mobilni_operater,
                  () => setState(() {
                    openMobile = !openMobile;
                  }),
                ),
                openMobile
                    ? Column(
                        children: <Widget>[
                          const SizedBox(height: 15),
                          _buildMobileList(context),
                        ],
                      )
                    : const SizedBox(),
                const SizedBox(height: 20),
                _buildExpandableWidget(
                  context,
                  dopuna_iznos,
                  () => setState(() {
                    openAmount = !openAmount;
                  }),
                ),
                openAmount
                    ? Column(
                        children: <Widget>[
                          const SizedBox(height: 15),
                          _buildAmountList(context),
                        ],
                      )
                    : const SizedBox(),
              ],
            ),
      const SizedBox(height: 50),
    ]);
  }

  Widget _buildImageHeader(BuildContext context) {
    return Image.asset('assets/dopuna_header.png');
  }

  Widget _buildExpandableWidget(BuildContext context, String title, Function onTap) {
    return GestureDetector(
      onTap: () => onTap(),
      child: Container(
        height: 45,
        decoration: BoxDecoration(color: ColorHelper.lampGray.color, borderRadius: BorderRadius.circular(15)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Text(title,
                  style: Theme.of(context).textTheme.headline4!.copyWith(color: ColorHelper.white.color, fontStyle: FontStyle.normal, fontSize: 18)),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 15),
              child: Image.asset('assets/ic_arrow_dropdown.png', width: 15),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildExpandedCheckItem(BuildContext context, String? image, bool checked, Function onTap, {String text = ''}) {
    return GestureDetector(
      onTap: () => onTap(),
      child: Container(
        height: 47,
        margin: const EdgeInsets.only(top: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: ColorHelper.lampLightGray.color),
          color: checked ? ColorHelper.lampGreen.color : ColorHelper.white.color,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Container(
              padding: const EdgeInsets.only(left: 15),
              child: image != null
                  ? Image.asset(image)
                  : Text(
                      text,
                      style: TextStyle(color: ColorHelper.lampGray.color, fontWeight: FontWeight.w500, fontFamily: 'Ubuntu', fontSize: 16),
                    ),
            ),
            !checked
                ? Container(
                    padding: const EdgeInsets.only(right: 15),
                    child: Image.asset('assets/ic_empty_check.png', width: 30),
                  )
                : Stack(
                    alignment: Alignment.center,
                    children: <Widget>[
                      Container(
                        padding: const EdgeInsets.only(right: 15),
                        child: Image.asset('assets/ic_full_check.png', width: 16),
                      ),
                      Container(
                        padding: const EdgeInsets.only(right: 15),
                        child: Image.asset('assets/ic_full_check_outline.png', width: 30),
                      )
                    ],
                  ),
          ],
        ),
      ),
    );
  }

  Widget _buildMobileList(BuildContext context) {
    final List<MobileOperator> operators = context.watch<DopunaProvider>().mobileOperators;
    return ListView(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      children: operators
          .map((e) => _buildExpandedCheckItem(
                context,
                context.read<DopunaProvider>().returnImgBasedOnValue(e.value),
                e.selected,
                () => context.read<DopunaProvider>().selectMobile(e.value),
              ))
          .toList(),
    );
  }

  Widget _buildAmountList(BuildContext context) {
    final List<DopunaAmount> amounts = context.watch<DopunaProvider>().amounts;
    return ListView(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        children: amounts
            .map((e) => _buildExpandedCheckItem(
                  context,
                  null,
                  e.selected,
                  text: e.text,
                  () => context.read<DopunaProvider>().selectAmount(e.value),
                ))
            .toList());
  }

  Widget _buildPhoneNumberField(BuildContext context) {
    return Lamp_TextFormField(
      hintText: 'Unesi broj telefona',
      keyboardType: TextInputType.number,
      controller: context.read<DopunaProvider>().phoneNumberController,
      onChange: () {
        context.read<DopunaProvider>().notifyWhoListen();
      },
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
            Text(dopuna_success, style: Theme.of(context).textTheme.headline4!.copyWith(fontStyle: FontStyle.normal)),
          ],
        ),
      ),
    );
  }
}
