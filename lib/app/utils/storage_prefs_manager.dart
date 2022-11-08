import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

final StoragePrefsManager storagePrefs = StoragePrefsManager();

class StoragePrefsManager {
  late SharedPreferences _shared_pref_instance;
  late FlutterSecureStorage _storage_instance;

  Future<void> init() async {
    _shared_pref_instance = await SharedPreferences.getInstance();
    _storage_instance = const FlutterSecureStorage();
  }

  //Secure Storage
  static const String USER_DATA_KEY = 'userData';
  static const String ACCESS_TOKEN = 'LAMPICA_ACCESS_TOKEN_KEY';
  static const String FIRST_RUN = 'firstRun';
  static const String FINISHED_ONBOARDING = 'finishedOnboarding';

  Future<void> setValue(String key, String value) async {
    const IOSOptions options = IOSOptions(accessibility: KeychainAccessibility.first_unlock);
    await _storage_instance.write(key: key, value: value, iOptions: options);
  }

  Future<String> getValue(String key) async {
    final String? result = await _storage_instance.read(key: key);
    return result ?? '';
  }

  Future<void> deleteAll() async {
    await _storage_instance.deleteAll();
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }

  Future<void> deleteForKey(String key) async {
    await _storage_instance.delete(key: key);
  }

  Future<void> setEmailInShared(String email) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('user_email', email);
  }

  Future<String> readEmailFromShared() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? userEmail = prefs.getString('user_email');
    return userEmail ?? '';
  }

  Future<void> setLanguage(String language) async {
    if (!['si', 'en'].contains(language)) {
      await _shared_pref_instance.setString('language_code', 'si');
      return;
    }

    await _shared_pref_instance.setString('language_code', language);
  }

  Future<String> getLanguage() async {
    String? languageCode = _shared_pref_instance.getString('language_code');
    return languageCode ?? 'si';
  }
}
