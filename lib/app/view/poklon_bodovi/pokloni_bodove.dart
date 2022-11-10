import 'package:flutter/material.dart';
import 'package:flutter_multi_formatter/formatters/masked_input_formatter.dart';
import 'package:lamp/app/providers/send_points_provider/send_points_provider.dart';
import 'package:lamp/app/utils/string_texts.dart';
import 'package:lamp/common_widgets/buttons/button.dart';
import 'package:lamp/common_widgets/dialog/lamp_dialog.dart';
import 'package:lamp/common_widgets/loader/lamp_loader.dart';
import 'package:provider/provider.dart';

import '../../../common_widgets/app_bar/app_bar.dart';
import '../../../common_widgets/error_widget/info_widget.dart';
import '../../../common_widgets/text_field/TextFieldType.dart';
import '../../../theme/color_helper.dart';

class PokloniBodove extends StatelessWidget {
  const PokloniBodove({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBarPokloniBodove(context),
      body: SafeArea(child: _buildBody(context)),
      resizeToAvoidBottomInset: false,
    );
  }

  PreferredSizeWidget _appBarPokloniBodove(BuildContext context) {
    return Lamp_AppBarIconTitleIcon(
      context,
      title: pokloni_app_bar,
      onLeadingPressed: () => Navigator.of(context).pop(),
      centerTitle: false,
      leadingIcon: Icons.arrow_back_ios_new,
      leadingIconColor: ColorHelper.lampGray.color,
    );
  }

  Widget _buildBody(BuildContext context) {
    return ListView(
      children: [
        const SizedBox(height: 40),
        Padding(padding: const EdgeInsets.symmetric(horizontal: 24), child: Image.asset('assets/pokloni_bodove.png')),
        const SizedBox(height: 40),
        context.watch<SendPointsProvider>().pointsSendSuccess
            ? Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: _buildSuccessWidget(context),
            )
            : Padding(
                padding: const EdgeInsets.symmetric(horizontal: 57),
                child: Column(
                  children: <Widget>[cardNumberField(context), const SizedBox(height: 15), pointNumberField(context),  const SizedBox(height: 33), pokloniBodoveButton(context)],
                ),
              ),
      ],
    );
  }

  Widget cardNumberField(BuildContext context) {
    return Lamp_TextFormField(
      inputFormatters: [MaskedInputFormatter('### ### ###')],
      hintText: pokloni_card_number_field,
      keyboardType: TextInputType.number,
      controller: context.read<SendPointsProvider>().cardNoController,
    );
  }

  Widget pointNumberField(BuildContext context) {
    return Lamp_TextFormField(
      hintText: pokloni_amount_field,
      keyboardType: TextInputType.number,
      controller: context.read<SendPointsProvider>().amountController,
    );
  }

  Widget pokloniBodoveButton(BuildContext context) {
    return Lamp_Button(
        buttonTitle: pokloni_btn,
        onPressed: () {
          Lamp_LoaderCircleWhite(context: context);
          context.read<SendPointsProvider>().getRecipientsInfo().then((String? error) {
            if (error == null) {
              context.read<SendPointsProvider>().pointsSendingNumber().then((String? _error) {
                if (_error == null) {
                  context.read<SendPointsProvider>().sendPoints().then((String? e) {
                    Navigator.of(context).pop();
                    if (e == null) {
                      context.read<SendPointsProvider>().pointsSendSuccessSet(true);
                    } else {
                      context.read<SendPointsProvider>().pointsSendSuccessSet(false);
                      Lamp_SimpleDialog(context,
                          content: e, title: common_greska_error, buttonText: common_btn_ok, onButtonPressed: () => Navigator.of(context).pop());
                    }
                  });
                } else {
                  context.read<SendPointsProvider>().pointsSendSuccessSet(false);
                  Navigator.of(context).pop();
                  Lamp_SimpleDialog(context,
                      content: _error, title: common_greska_error, buttonText: common_btn_ok, onButtonPressed: () => Navigator.of(context).pop());
                }
              });
            } else {
              context.read<SendPointsProvider>().pointsSendSuccessSet(false);
              Navigator.of(context).pop();
              Lamp_SimpleDialog(context,
                  content: error, title: common_greska_error, buttonText: common_btn_ok, onButtonPressed: () => Navigator.of(context).pop());
            }
          });
        });
  }

  Widget _buildSuccessWidget(BuildContext context) {
    return Container(
      height: 203,
      margin: EdgeInsets.only(top: MediaQuery.of(context).size.height / 12),
      decoration: BoxDecoration(
        border: Border.all(color: ColorHelper.lampLightGray.color),
        borderRadius: BorderRadius.circular(11),
        boxShadow: const [
          BoxShadow(
            color: Color.fromRGBO(0, 0, 0, 0.17),
            blurRadius: 4,
            blurStyle: BlurStyle.outer,
          ),
        ],
      ),
      padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          Image.asset('assets/ic_success.png', width: 48),
          Text('Bodovi su uspješno poklonjeni!', style: Theme.of(context).textTheme.headline4!.copyWith(fontStyle: FontStyle.normal, fontSize: 20, fontWeight: FontWeight.w500)),
        ],
      ),
    );
  }
}
