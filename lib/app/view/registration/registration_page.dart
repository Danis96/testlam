import 'package:flutter/material.dart';
import 'package:flutter_multi_formatter/formatters/masked_input_formatter.dart';
import 'package:lamp/app/providers/auth_provider/auth_provider.dart';
import 'package:lamp/app/utils/storage_prefs_manager.dart';
import 'package:lamp/common_widgets/buttons/button.dart';
import 'package:lamp/common_widgets/dialog/lamp_dialog.dart';
import 'package:lamp/common_widgets/error_widget/info_widget.dart';
import 'package:lamp/common_widgets/loader/lamp_loader.dart';
import 'package:lamp/common_widgets/tappable_text/tappable_text.dart';
import 'package:lamp/common_widgets/text_field/TextFieldType.dart';
import 'package:lamp/routing/routes.dart';
import 'package:lamp/theme/color_helper.dart';
import 'package:provider/provider.dart';

import '../../utils/string_texts.dart';

class RegistrationPage extends StatefulWidget {
  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  bool showPass = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildBody(context),
      bottomNavigationBar: _buildForgotPin(context),
    );
  }

  var email = TextFormField(
    keyboardType: TextInputType.emailAddress,
    autofocus: false,
    textAlign: TextAlign.center,
    style: new TextStyle(fontWeight: FontWeight.w400, color: Colors.white, fontSize: 16),
    decoration: InputDecoration(
      fillColor: Colors.amber,
      contentPadding: const EdgeInsets.symmetric(vertical: 14, horizontal: 10.0),
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(15.0)),
    ),
  );

  Widget _buildBody(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 56),
      shrinkWrap: true,
      children: <Widget>[
        const SizedBox(height: 50),
        _buildImg(context),
        const SizedBox(height: 50),
        _buildForm(context),
      ],
    );
  }

  Widget _buildImg(BuildContext context) {
    return Image.asset('assets/lampica_logo.png', height: 150, width: 150);
  }

  Widget _buildForm(BuildContext context) {
    return Column(
      children: <Widget>[
        _buildCardNumberField(context),
        _buildPINField(context),
        SizedBox(height: MediaQuery.of(context).size.height * 0.02),
        _buildButton(context),
        SizedBox(height: MediaQuery.of(context).size.height * 0.02),
        context.watch<AuthProvider>().showError ? _wrongData(context) : const SizedBox(),
        context.watch<AuthProvider>().showErrorFromAPI ? _wrongData(context, error: context.read<AuthProvider>().error) : const SizedBox(),
      ],
    );
  }

  Widget _buildCardNumberField(BuildContext context) {
    return Lamp_TextFormField(
      hintText: '',
      inputFormatters: [MaskedInputFormatter('### ### ###')],
      controller: context.read<AuthProvider>().usernameController,
      label: prijava_card_number_field_label,
      keyboardType: TextInputType.number,
    );
  }

  Widget _buildPINField(BuildContext context) {
    return Stack(
      children: [
        Lamp_TextFormField(
          hintText: '',
          controller: context.read<AuthProvider>().codeController,
          label: prijava_pin_field_label,
          keyboardType: TextInputType.number,
          obscureText: !showPass,
        ),
        Positioned(
            bottom: 34,
            right: 26,
            child: GestureDetector(
                onTap: () {
                  setState(() {
                    showPass = !showPass;
                  });
                },
                child: Icon(size: 22, showPass ? Icons.visibility_off_outlined : Icons.visibility_outlined, color: ColorHelper.lampGray.color))),
      ],
    );
  }

  Widget _buildButton(BuildContext context) {
    return Lamp_Button(
      onPressed: () {
        Lamp_LoaderCircleWhite(context: context);
        context.read<AuthProvider>().getToken().then((String? error) {
          Navigator.of(context).pop();
          if (error == null) {
            Navigator.of(context).pushNamed(bottomNavigation);
          } else {
            if (error == common_sva_polja_error) {
              context.read<AuthProvider>().setShowErrorFromApi(true, error);
              // Lamp_SimpleDialog(
              //   context,
              //   title: common_greska_error,
              //   content: error,
              //   onButtonPressed: () => Navigator.of(context).pop(),
              //   buttonText: common_btn_ok,
              // );
            } else if (error == 'Korisnički podaci nisu ispravni.') {
              context.read<AuthProvider>().setShowErrorFromApi(true, error);
              // Lamp_SimpleDialog(
              //   context,
              //   title: common_greska_error,
              //   content: error,
              //   onButtonPressed: () => Navigator.of(context).pop(),
              //   buttonText: common_btn_ok,
              // );
            } else {
              context.read<AuthProvider>().setShowError(true);
              if (!context.read<AuthProvider>().isNumeric(error)) {
                Lamp_SimpleDialog(
                  context,
                  title: common_greska_error,
                  content: error,
                  onButtonPressed: () => Navigator.of(context).pop(),
                  buttonText: common_btn_ok,
                );
              }
            }
          }
        });
      },
      buttonTitle: prijava_btn,
    );
  }

  Widget _buildForgotPin(BuildContext context) {
    return SizedBox(
      height: 60,
      child: Lamp_TappableText(
        text: prijava_zaboravljen_pin,
        links: prijava_zaboravljen_pin,
        onPressed: (int i) => Navigator.of(context).pushNamed(changePassword, arguments: context.read<AuthProvider>()),
        linkStyle: Theme.of(context).textTheme.headline3!,
      ),
    );
  }

  Widget _wrongData(BuildContext context, {String? error}) {
    return Lamp_InfoWidget(
        title: prijava_error_title,
        subtitle: error ?? '$prijava_error_subtitle ${context.watch<AuthProvider>().numberOfAttempts} $prijava_error_subtitle2',
        isError: true);
  }
}
