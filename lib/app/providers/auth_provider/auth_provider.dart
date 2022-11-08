import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:lamp/app/models/token_model.dart';
import 'package:lamp/app/providers/provider_helper.dart';
import 'package:lamp/app/repositories/auth_repo.dart';
import 'package:lamp/app/utils/storage_prefs_manager.dart';
import 'package:lamp/app/utils/string_texts.dart';

class AuthProvider extends ChangeNotifier {
  AuthProvider() {
    _authRepository = AuthRepository();
  }

  AuthRepository? _authRepository;

  final TextEditingController usernameController = TextEditingController();
  final TextEditingController codeController = TextEditingController();

  // change password controllers
  final TextEditingController changePassUsernameController = TextEditingController();

  TokenModel _tokenModel = TokenModel();

  TokenModel get tokenModel => _tokenModel;

  Future<String?> getToken() async {
    if (usernameController.text.isNotEmpty && codeController.text.isNotEmpty) {
      try {
        final List<String> _c = usernameController.text.split(' ');
        String _combined = '';
        if(_c.isNotEmpty && _c.length >= 2) {
          _combined = _c[0] + _c[1] + _c[2];
        }
        _tokenModel = await _authRepository!.getToken(_combined, codeController.text);
        await storagePrefs.setValue(StoragePrefsManager.ACCESS_TOKEN, _tokenModel.accessToken);
        storagePrefs.setEmailInShared(usernameController.text);
        notifyListeners();
        return null;
      } catch (e) {
        debugPrint(e.toString());
        if (isNumeric(e.toString())) {
          numberOfAttempts = e.toString();
        } else {
          numberOfAttempts = '0';
        }
        notifyListeners();
        return e.toString();
      }
    } else {
      return common_sva_polja_error;
    }
  }

  bool isNumeric(String str) {
    if (str == null) {
      return false;
    }
    return double.tryParse(str) != null;
  }

  Future<String?> getAccessToken() async {
    if (_tokenModel != TokenModel()) {
      if (_tokenModel.accessToken != '' && _tokenModel.accessToken != null) {
        return _tokenModel.accessToken;
      } else {
        return null;
      }
    } else {
      final String at = await storagePrefs.getValue(StoragePrefsManager.ACCESS_TOKEN);
      return at;
    }
  }

  bool showError = false;
  bool showErrorFromAPI = false;
  String numberOfAttempts = '';
  String error = '';

  void setShowError(bool value) {
    showError = value;
    notifyListeners();
  }

  //call this on prijava i zavrsi meeee
  void setShowErrorFromApi(bool value, String errorValue) {
    showErrorFromAPI = value;
    error = errorValue;
    notifyListeners();
  }

  bool showSuccessChangePass = false;

  void setShowSuccessChangePass(bool value) {
    showSuccessChangePass = value;
    notifyListeners();
  }

  Future<String?> checkPin() async {
    try {
      await _authRepository!.checkPin(codeController.text);
      notifyListeners();
      return null;
    } catch (e) {
      return e.toString();
    }
  }

  Future<String?> changePassword() async {
    try {
      if (changePassUsernameController.text.isNotEmpty) {
        await _authRepository!.changePassword(changePassUsernameController.text);
        notifyListeners();
        return null;
      }
    } catch (e) {
      return ProviderHelper().changePasswordError(e.toString());
    }
  }

  Future<String?> logout() async {
    try {
      storagePrefs.deleteAll();
      notifyListeners();
      return null;
    } catch (e) {
      print('Logout $e');
      return e.toString();
    }
  }
}
