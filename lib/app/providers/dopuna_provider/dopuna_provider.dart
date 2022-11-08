import 'package:flutter/material.dart';
import 'package:lamp/app/models/dopuna_amount.dart';
import 'package:lamp/app/models/dopuna_mobile_operator.dart';

import '../../repositories/refill_repo.dart';
import '../provider_constant.dart';
import '../provider_helper.dart';

class DopunaProvider extends ChangeNotifier {
  DopunaProvider() {
    _refillRepository = RefillRepository();
  }

  RefillRepository? _refillRepository;

  TextEditingController phoneNumberController = TextEditingController();

  List<MobileOperator> _mobileOperators = <MobileOperator>[];

  List<MobileOperator> get mobileOperators => _mobileOperators;

  List<DopunaAmount> _amounts = <DopunaAmount>[];

  List<DopunaAmount> get amounts => _amounts;

  bool isDopunaSuccess = false;

  void setDopunaSuccess(bool value) {
    isDopunaSuccess = value;
    notifyListeners();
  }

  void notifyWhoListen() {
    notifyListeners();
  }

  Future<String?> getMobileOperators() async {
    try {
      _mobileOperators = await _refillRepository!.getMobileOperators();
      notifyListeners();
      return null;
    } catch (e) {
      return e.toString();
    }
  }

  Future<String?> getRefillAmount() async {
    try {
      _amounts = await _refillRepository!.geRefillAmount();
      notifyListeners();
      return null;
    } catch (e) {
      return e.toString();
    }
  }

  Future<String?> sendSmsTopUp() async {
    final MobileOperator o = mobileOperators.firstWhere((element) => element.selected);
    final DopunaAmount d = amounts.firstWhere((element) => element.selected);
    try {
      await _refillRepository!.sendSmsTopUp(d.value, o.value, phoneNumberController.text);
      notifyListeners();
      return null;
    } catch (e) {
      return ProviderHelper().sendSmsTopUp(e.toString());
    }
  }

  String returnImgBasedOnValue(String value) {
    if (value == '0') {
      return ULTRA;
    } else if (value == '1') {
      return HEJ;
    } else if (value == '2') {
      return HALOO;
    } else if (value == '3'){
      return MTEL;
    } else {
      return '';
    }
  }

  void selectMobile(String arg) {
    if (mobileOperators.isNotEmpty) {
      for (final MobileOperator m in mobileOperators) {
        if (arg == m.value) {
          m.selected = true;
        } else {
          m.selected = false;
        }
      }
    }
    notifyListeners();
  }

  void selectAmount(String arg) {
    if (amounts.isNotEmpty) {
      for (final DopunaAmount d in amounts) {
        if (arg == d.value) {
          d.selected = true;
        } else {
          d.selected = false;
        }
      }
    }
    notifyListeners();
  }

  bool isAmountChosen() {
    if (amounts.isNotEmpty) {
      for (final DopunaAmount d in amounts) {
        if (d.selected == true) {
          return true;
        }
      }
    }
    return false;
  }

  bool isMobileChosen() {
    if (mobileOperators.isNotEmpty) {
      for (final MobileOperator d in mobileOperators) {
        if (d.selected == true) {
          return true;
        }
      }
    }
    return false;
  }

  bool isPhoneNumberEmpty() {
    return phoneNumberController.text.isNotEmpty;
  }
}
