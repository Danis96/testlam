import 'package:device_display_brightness/device_display_brightness.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ScreenBrightnessProvider extends ChangeNotifier {
  ScreenBrightnessProvider() {
    initPlatformBrightness();
  }


  Future<void> initPlatformBrightness() async {
    double bright;
    try {
      bright = await DeviceDisplayBrightness.getBrightness();
    } on PlatformException {
      bright = 1.0;
    }
    await DeviceDisplayBrightness.setBrightness(bright);
    notifyListeners();
  }

  Future<double> get systemBrightness async {
    try {
      notifyListeners();
      return await DeviceDisplayBrightness.getBrightness();
    } catch (e) {
      print(e);
      throw 'Failed to get system brightness';
    }
  }

  Future<void> setBrightness(double brightness) async {
    try {
      await DeviceDisplayBrightness.setBrightness(brightness);
      notifyListeners();
    } catch (e) {
      print(e);
      throw 'Failed to set brightness';
    }
  }

  Future<void> preventScreenWake() async {
    try {
      bool isKeptOn = await DeviceDisplayBrightness.isKeptOn();
      if (isKeptOn) {
      } else {
        DeviceDisplayBrightness.keepOn(enabled: true);
      }
    } catch (e) {
      print(e);
      throw 'Failed to preventScreenWake';
    }
  }
}
