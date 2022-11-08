import 'package:flutter/material.dart';
import 'package:lamp/app/models/promo_code_model.dart';
import 'package:lamp/app/providers/provider_helper.dart';
import 'package:lamp/app/repositories/promo_code_repo.dart';
import 'package:lamp/network_module/api_exceptions.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

import '../../models/user_main_info.dart';
import '../../repositories/account_repo.dart';

class PromoCodeProvider extends ChangeNotifier {
  PromoCodeProvider() {
    _promoCodeRepository = PromoCodeRepository();
    _accountRepository = AccountRepository();
    showPromoCodeError = false;
    showPromoCodeSuccess = false;
  }

  PromoCodeRepository? _promoCodeRepository;
  AccountRepository? _accountRepository;

  TextEditingController promoCodeController = TextEditingController();

  UserMainInfo _userMainInfo = UserMainInfo();

  UserMainInfo get userMainInfo => _userMainInfo;

  PromoCodeModel _promoCodeModel = PromoCodeModel();

  PromoCodeModel get promoCodeModel => _promoCodeModel;

  bool showPromoCodeError = false;

  void setPromoCodeError(bool value) {
    showPromoCodeError = value;
    notifyListeners();
  }

  bool showPromoCodeSuccess = false;

  void setPromoCodeSuccess(bool value) {
    showPromoCodeSuccess = value;
    notifyListeners();
  }

  int brojPokusaja = 5;

  Future<String?> sendPromoCode() async {
    try {
      _userMainInfo = await _accountRepository!.getUserMainInformation();
      if (_userMainInfo.cardNumber.isNotEmpty) {
        try {
          _promoCodeModel = await _promoCodeRepository!.sendPromoCode(_userMainInfo.cardNumber, promoCodeController.text);
          setPromoCodeError(false);
          setPromoCodeSuccess(true);
          notifyListeners();
          return ProviderHelper().promoCodeError(_promoCodeModel);
        } catch (e) {
          e as BadRequestValidationException;
          setPromoCodeError(true);
          setPromoCodeSuccess(false);
          if(e.mapError != null ) {
            if(e.mapError!['RemainingAttempts'] != null) {
              brojPokusaja = e.mapError!['RemainingAttempts'];
            } else {
              brojPokusaja = 0;
            }
          }
          notifyListeners();
          return ProviderHelper().promoCodeError(e.mapError);
        }
      }
    } catch (e) {
      print('User main info $e');
    }
    notifyListeners();
  }

  bool isQRCodeScanPressed = false;

  void setQRCodePressed(bool value) {
    isQRCodeScanPressed = value;
    notifyListeners();
  }

  void isResultFound(Barcode? result) {
    if (result != null && result.code != null) {
      setQRCodePressed(false);
    } else {
      setQRCodePressed(true);
    }
  }
}
