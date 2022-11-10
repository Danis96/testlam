import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lamp/app/providers/account_provider/account_provider.dart';
import 'package:lamp/app/providers/donation_provider/donation_provider.dart';
import 'package:lamp/app/utils/string_texts.dart';
import 'package:lamp/common_widgets/buttons/button.dart';
import 'package:lamp/common_widgets/dialog/lamp_dialog.dart';
import 'package:lamp/common_widgets/loader/lamp_loader.dart';
import 'package:provider/provider.dart';

import '../../../common_widgets/app_bar/app_bar.dart';
import '../../../common_widgets/text_field/TextFieldType.dart';
import '../../../theme/color_helper.dart';

class PomoziBa extends StatelessWidget {
  const PomoziBa({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBarPomoziBa(context),
      body: SafeArea(child: _buildBody(context)),
      resizeToAvoidBottomInset: false,
    );
  }

  PreferredSizeWidget _appBarPomoziBa(BuildContext context) {
    return Lamp_AppBarIconTitleIcon(
      context,
      title: pomozi_app_bar,
      onLeadingPressed: () => Navigator.of(context).pop(),
      centerTitle: false,
      leadingIcon: Icons.arrow_back_ios_new,
      leadingIconColor: ColorHelper.lampGray.color,
      onActionPressed: null,
    );
  }

  Widget _buildBody(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      children: [
        const SizedBox(
          height: 40,
        ),
        Container(
            // decoration: BoxDecoration(
            //   border: Border.all(color: const Color.fromRGBO(0, 0, 0, 0.1)),
            //   borderRadius: BorderRadius.circular(32),
            //   boxShadow: const [
            //     BoxShadow(
            //       color: Color.fromRGBO(0, 0, 0, 0.16),
            //       blurRadius: 4,
            //       blurStyle: BlurStyle.outer,
            //     ),
            //   ],
            // ),
            child: Image.asset('assets/pomoziba.png')),
        const SizedBox(
          height: 40,
        ),
        context.watch<DonationProvider>().isPomoziBaSuccess
            ? _successWidget(context)
            : Column(
                children: [
                  pointNumberField(context),
                  pokloniBodoveButton(context),
                  const SizedBox(
                    height: 40,
                  ),
                  _msg(),
                ],
              ),
        const SizedBox(
          height: 40,
        ),
      ],
    );
  }

  Widget pointNumberField(BuildContext context) {
    return Lamp_TextFormField(
      hintText: pomozi_point_number_field,
      controller: context.read<DonationProvider>().pomoziBaAmountController,
      keyboardType: TextInputType.number,
    );
  }

  Widget pokloniBodoveButton(BuildContext context) {
    return Lamp_Button(
      buttonTitle: pomozi_pokloni_bodove_btn,
      onPressed: () {
        Lamp_LoaderCircleWhite(context: context);
        context.read<DonationProvider>().setUserAsDonator().then((String? error) {
          if (error != null) {
            Lamp_SimpleDialog(context, title: common_greska_error, onButtonPressed: () => Navigator.of(context).pop(), content: error);
          } else {
            context.read<DonationProvider>().setPomoziBaDonation().then((String? error) async {
              Navigator.of(context).pop();
              if (error != null) {
                Lamp_SimpleDialog(context, title: common_greska_error, onButtonPressed: () => Navigator.of(context).pop(), content: error);
                context.read<DonationProvider>().setPomoziBaDonationToSuccess(false);
              } else {
                context.read<DonationProvider>().setPomoziBaDonationToSuccess(true);
              }
            });
          }
        });
      },
    );
  }

  Widget _msg() {
    return Container(
      height: 117,
      padding: EdgeInsets.symmetric(horizontal: 10),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        border: Border.all(color: ColorHelper.lampLightGray.color),
        borderRadius: const BorderRadius.all(
          Radius.circular(15.0),
        ),
        boxShadow: const [
          BoxShadow(
            color: Color.fromRGBO(0, 0, 0, 0.16),
            blurRadius: 4,
            blurStyle: BlurStyle.outer,
          ),
        ],
      ),
      child: Text(
        '''Budimo humani,
        jer imamo samo ono što damo.''',
        textAlign: TextAlign.center,
        style: TextStyle(
          color: ColorHelper.lampGray.color,
          fontSize: 19,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}

Widget _successWidget(BuildContext context) {
  return Container(
    height: 300,
    decoration: BoxDecoration(
      border: Border.all(color: ColorHelper.lampLightGray.color),
      borderRadius: BorderRadius.circular(11),
      boxShadow: const [
        BoxShadow(
          color: Color.fromRGBO(0, 0, 0, 0.16),
          blurRadius: 4,
          blurStyle: BlurStyle.outer,
        ),
      ],
    ),
    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Image.asset('assets/ic_success.png', width: 50),
        Text(pomozi_bodovi_uspjesno_title, style: Theme.of(context).textTheme.headline2!.copyWith(fontWeight: FontWeight.w500)),
        Text(pomozi_bodovi_uspjesno_subtitle, textAlign: TextAlign.center, style: Theme.of(context).textTheme.headline4),
      ],
    ),
  );
}
