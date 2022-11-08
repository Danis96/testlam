import 'dart:io';

import 'package:flutter/material.dart';
import 'package:lamp/app/providers/promo_code_provider/promo_code_provider.dart';
import 'package:lamp/common_widgets/buttons/button.dart';
import 'package:lamp/common_widgets/dialog/lamp_dialog.dart';
import 'package:lamp/common_widgets/error_widget/info_widget.dart';
import 'package:lamp/common_widgets/loader/lamp_loader.dart';
import 'package:lamp/common_widgets/text_field/TextFieldType.dart';
import 'package:lamp/theme/color_helper.dart';
import 'package:provider/provider.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

import '../../../common_widgets/app_bar/app_bar.dart';
import '../../utils/string_texts.dart';

class PromoCodePage extends StatefulWidget {
  const PromoCodePage({Key? key}) : super(key: key);

  @override
  State<PromoCodePage> createState() => _PromoCodePageState();
}

class _PromoCodePageState extends State<PromoCodePage> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  Barcode? result;
  QRViewController? controller;

  // In order to get hot reload to work we need to pause the camera if the platform
  // is android, or resume the camera if the platform is iOS.
  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller!.pauseCamera();
    } else if (Platform.isIOS) {
      controller!.resumeCamera();
    }
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  Widget _buildQrView(BuildContext context) {
    var scanArea = (MediaQuery.of(context).size.width < 400 || MediaQuery.of(context).size.height < 400) ? 150.0 : 300.0;

    return SizedBox(
      height: 240,
      child: QRView(
          key: qrKey,
          onQRViewCreated: _onQRViewCreated,
          overlay: QrScannerOverlayShape(
              borderColor: ColorHelper.lampGreen.color, borderRadius: 10, borderLength: 30, borderWidth: 10, cutOutSize: scanArea)),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    setState(() {
      this.controller = controller;
    });
    controller.scannedDataStream.listen((scanData) {
      setState(() {
        result = scanData;
        context.read<PromoCodeProvider>().isResultFound(result!);
        if (result != null && result!.code != null) {
          context.read<PromoCodeProvider>().promoCodeController.text = result!.code!;
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      body: _buildBody(context),
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return Lamp_AppBarIconTitleIcon(
      context,
      onActionPressed: null,
      implyAction: false,
      onLeadingPressed: () => Navigator.of(context).pop(),
      centerTitle: false,
      leadingIcon: Icons.arrow_back_ios,
      leadingIconColor: ColorHelper.lampGray.color,
      title: 'Promo kod',
    );
  }

  Widget _buildBody(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      padding: const EdgeInsets.symmetric(horizontal: 24),
      children: <Widget>[
        const SizedBox(height: 40),
        context.watch<PromoCodeProvider>().isQRCodeScanPressed ? _buildQrView(context) : _buildScanCodeField(context),
        _buildPromoCodeField(context),
        const SizedBox(height: 20),
        _buildButton(context),
        const SizedBox(height: 70),
        _returnCorrespondingInfo(context),
        const SizedBox(height: 40),
      ],
    );
  }

  Widget _returnCorrespondingInfo(BuildContext context) {
    return context.watch<PromoCodeProvider>().showPromoCodeSuccess
        ? _promoCodeSuccess(context)
        : context.watch<PromoCodeProvider>().showPromoCodeError
            ? _promoCodeError(context)
            : _buildAdditionalInfo(context);
  }

  Widget _buildScanCodeField(BuildContext context) {
    return Lamp_TextFormField(
      hintText: 'Skeniraj QR kod',
      readOnly: true,
      controller: TextEditingController(),
      textAlign: TextAlign.start,
      icon: IconButton(
        icon: Icon(Icons.qr_code, size: 30, color: ColorHelper.lampGray.color),
        onPressed: () {
          context.read<PromoCodeProvider>().setQRCodePressed(true);
        },
      ),
    );
  }

  Widget _buildPromoCodeField(BuildContext context) {
    return Lamp_TextFormField(
      hintText: 'Unesi promo kod',
      controller: context.read<PromoCodeProvider>().promoCodeController,
      textAlign: TextAlign.start,
    );
  }

  Widget _buildButton(BuildContext context) {
    return Lamp_Button(
        onPressed: () {
          Lamp_LoaderCircleWhite(context: context);
          context.read<PromoCodeProvider>().sendPromoCode().then((String? error) {
            Navigator.of(context).pop();
            if (error != null) {
              Lamp_SimpleDialog(context,
                  title: common_greska_error, content: error, buttonText: common_btn_ok, onButtonPressed: () => Navigator.of(context).pop());
            }
          });
        },
        buttonTitle: 'Aktiviraj');
  }

  Widget _buildAdditionalInfo(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        border: Border.all(color: ColorHelper.lampLightGray.color),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: <Widget>[
          RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
              children: <TextSpan>[
                TextSpan(text: 'Aktiviranje promo koda se vrši na sljedeći način: ', style: Theme.of(context).textTheme.headline3),
                TextSpan(
                    text: '\nUpiše se promo kod u odgovarajuće polje i izvrši se njegovo aktiviranje ili se QR kod skenira i aktivira ',
                    style: Theme.of(context).textTheme.headline3!.copyWith(fontWeight: FontWeight.w600)),
                TextSpan(
                    text: '\nImate ukupno 5 pokušaja za aktiviranje, u suprotnom unos promo koda će biti privremeno blokiran.',
                    style: Theme.of(context).textTheme.headline3),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _promoCodeError(BuildContext context) {
    return Lamp_InfoWidget(
      title: 'Pogrešan unos! ',
      subtitle:
          'Imate još ${context.watch<PromoCodeProvider>().brojPokusaja} pokušaja za aktivaciju promo koda, u suprotnom unos promo koda će biti privremeno blokiran.',
      isError: true,
    );
  }

  Widget _promoCodeSuccess(BuildContext context) {
    return Card(
      child: Container(
        height: 150,
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset(
              'assets/ic_success.png',
              width: 50,
            ),
            const SizedBox(height: 20),
            Text('Promo kod je uspješno aktiviran!',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.subtitle1!.copyWith(color: ColorHelper.black.color, fontWeight: FontWeight.w500)),
          ],
        ),
      ),
    );
  }
}
