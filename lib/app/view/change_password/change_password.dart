import 'package:flutter/material.dart';
import 'package:flutter_multi_formatter/formatters/masked_input_formatter.dart';
import 'package:provider/provider.dart';

import '../../../common_widgets/app_bar/app_bar.dart';
import '../../../common_widgets/buttons/button.dart';
import '../../../common_widgets/error_widget/info_widget.dart';
import '../../../common_widgets/loader/lamp_loader.dart';
import '../../../common_widgets/text_field/TextFieldType.dart';
import '../../../theme/color_helper.dart';
import '../../providers/auth_provider/auth_provider.dart';
import '../../utils/string_texts.dart';

class ChangePassword extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      body: _buildBody(context),
    );
  }
}

PreferredSizeWidget _buildAppBar(BuildContext context) {
  return Lamp_AppBarIconTitleIcon(
    context,
    onActionPressed: null,
    implyAction: false,
    onLeadingPressed: () => Navigator.of(context).pop(),
    title: '',
    centerTitle: false,
    leadingIcon: Icons.arrow_back_ios_new,
    leadingIconColor: ColorHelper.lampGray.color,
  );
}

Widget _buildBody(BuildContext context) {
  return ListView(
    padding: const EdgeInsets.symmetric(horizontal: 54),
    shrinkWrap: true,
    children: <Widget>[
      _buildImg(context),
      const SizedBox(height: 50),
      _buildForm(context),
      _buildButton(context),
    ],
  );
}

Widget _buildImg(BuildContext context) {
  return Image.asset('assets/lampica_logo.png', height: 150, width: 150);
}

Widget _buildForm(BuildContext context) {
  return context.watch<AuthProvider>().showSuccessChangePass
      ? _pinChanged(context)
      : Column(
          children: <Widget>[
            _buildCardNumberField(context),
            SizedBox(height: MediaQuery.of(context).size.height * 0.02),
          ],
        );
}

Widget _buildCardNumberField(BuildContext context) {
  return Lamp_TextFormField(
    hintText: '',
    inputFormatters: [MaskedInputFormatter('### ### ###')],
    controller: context.read<AuthProvider>().changePassUsernameController,
    label: prijava_card_number_field_label,
    keyboardType: TextInputType.number,
  );
}


Widget _buildButton(BuildContext context) {
  return Lamp_Button(
    onPressed: () {
      Lamp_LoaderCircleWhite(context: context);
      context.read<AuthProvider>().changePassword().then((String? error) {
        Navigator.of(context).pop();
        if (error == null) {
          context.read<AuthProvider>().setShowSuccessChangePass(true);
        }
      });
    },
    buttonTitle: change_pass_btn,
  );
}

Widget _pinChanged(BuildContext context) {
  return Lamp_InfoWidget(title: change_success_headline, subtitle: change_success_subtitle);
}
