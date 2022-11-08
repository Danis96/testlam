import 'package:lamp/app/models/token_model.dart';

import '../../network_module/api_header.dart';
import '../../network_module/api_path.dart';
import '../../network_module/http_client.dart';

class AuthRepository {
  Future<TokenModel> getToken(String username, String pin) async {
    Map<String, String> object = <String, String>{};
    object['username'] = username;
    object['password'] = pin;
    object['grant_type'] = 'password';
    final Map<String, String> header = await ApiHeaderHelper.getValue(ApiHeader.appFormUrlEncoded);
    final dynamic response = await HTTPClient.instance.postData(ApiPathHelper.getValue(ApiPath.get_token), header, body: object);
    print(response);
    TokenModel tokenModel = TokenModel();
    if (response != null) {
      tokenModel = TokenModel.fromJson(response);
    }
    return tokenModel;
  }

  Future<void> checkPin(String pin) async {
    final Map<String, String> header = await ApiHeaderHelper.getValue(ApiHeader.appFormUrlEncoded);
    await HTTPClient.instance.postData(ApiPathHelper.getValue(ApiPath.check_pin, concatValue: pin), header);
  }

  Future<void> changePassword(String cardNumber) async {
    final Map<String, String> header = await ApiHeaderHelper.getValue(ApiHeader.authAppJson);
    await HTTPClient.instance.postData(ApiPathHelper.getValue(ApiPath.change_password, concatValue: cardNumber), header);
  }

  Future<void> logout(String registrationID) async {
    final Map<String, String> header = await ApiHeaderHelper.getValue(ApiHeader.authAppJson);
    final dynamic response = await HTTPClient.instance.postData(ApiPathHelper.getValue(ApiPath.logout, concatValue: registrationID), header);
    print('response');
  }
}
