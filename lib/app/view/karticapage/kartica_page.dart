import 'dart:io';
import 'package:device_display_brightness/device_display_brightness.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lamp/app/providers/account_provider/account_provider.dart';
import 'package:lamp/app/providers/screen_brightness_provider/screen_brightness_provider.dart';
import 'package:provider/provider.dart';

import '../../../common_widgets/loader/lamp_loader.dart';
import '../../utils/string_texts.dart';

class KarticaPage extends StatefulWidget {
  @override
  State<KarticaPage> createState() => _KarticaPageState();
}

class _KarticaPageState extends State<KarticaPage> with WidgetsBindingObserver {
  double? _brightness;

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Lamp_LoaderCircleWhite(context: context);
      _getInitialData().then((value) {
        Navigator.of(context).pop();
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  Future<void> _getInitialData() async {
    await _getBrightness();
    await context.read<AccountProvider>().setBarcodeSvg();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    if (state == AppLifecycleState.resumed) {
      await _getBrightness();
    }
  }

  Future<void> _getBrightness() async {
    DeviceDisplayBrightness.keepOn(enabled: false);
    await DeviceDisplayBrightness.resetBrightness();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: SafeArea(child: _buildBody(context)));
  }

  Widget _buildBody(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      children: <Widget>[
        _buildIcon(context),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25.0),
          child: _buildCard(context),
        ),
      ],
    );
  }

  Widget _buildIcon(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height / 3.5,
      alignment: Alignment.center,
      child: Image.asset('assets/logo_with_text.png'),
    );
  }

  Widget _buildCard(BuildContext context) {
    return Container(
      height: 300,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(15), border: Border.all(color: Colors.grey)),
      child: Column(
        children: [
          const SizedBox(
            height: 40,
          ),
          GestureDetector(
            onTap: () async {
              await context.read<ScreenBrightnessProvider>().setBrightness(1);
              DeviceDisplayBrightness.keepOn(enabled: true);
            },
            child: Container(
              height: 174,
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: context.watch<AccountProvider>().barcodeSVGPath != null
                  ? SvgPicture.file(File(context.watch<AccountProvider>().barcodeSVGPath!))
                  : const SizedBox(),
            ),
          ),
          const SizedBox(
            height: 25,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                br_kartice,
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.w300),
              ),
              Text(
                context.watch<AccountProvider>().returnUsersCardNumber(),
                style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w400),
              ),
            ],
          )
        ],
      ),
    );
  }
}
