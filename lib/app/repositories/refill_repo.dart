import 'package:lamp/app/models/dopuna_amount.dart';
import 'package:lamp/app/models/dopuna_mobile_operator.dart';
import 'package:lamp/network_module/api_header.dart';

import '../../network_module/api_path.dart';
import '../../network_module/http_client.dart';

class RefillRepository {
  Future<List<MobileOperator>> getMobileOperators() async {
    List<MobileOperator> mobileOperators;
    final Map<String, String> header = await ApiHeaderHelper.getValue(ApiHeader.authAppFormUrlEncoded);
    final dynamic response = await HTTPClient.instance.fetchData(ApiPathHelper.getValue(ApiPath.get_mobile_operators), header);
    final List<dynamic> responseJson = response as List<dynamic>;
    mobileOperators = responseJson.map((e) => MobileOperator.fromJson(e)).toList();
    return mobileOperators;
  }

  Future<List<DopunaAmount>> geRefillAmount() async {
    List<DopunaAmount> amounts;
    final Map<String, String> header = await ApiHeaderHelper.getValue(ApiHeader.authAppFormUrlEncoded);
    final dynamic response = await HTTPClient.instance.fetchData(ApiPathHelper.getValue(ApiPath.get_refill_amount), header);
    final List<dynamic> responseJson = response as List<dynamic>;
    amounts = responseJson.map((e) => DopunaAmount.fromJson(e)).toList();
    return amounts;
  }

  Future<void> sendSmsTopUp(String amount, String mobile, String phone) async {
    final Map<String, String> header = await ApiHeaderHelper.getValue(ApiHeader.authAppFormUrlEncoded);
    Map<String, dynamic> object = <String, dynamic>{};
    object['Operater'] = mobile;
    object['Amount'] = amount;
    object['PhoneNumber'] = phone;
    final dynamic response = await HTTPClient.instance.postData(ApiPathHelper.getValue(ApiPath.send_refill), header, body: object);
    print(response);
  }
}
