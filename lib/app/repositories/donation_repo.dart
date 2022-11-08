import '../../network_module/api_header.dart';
import '../../network_module/api_path.dart';
import '../../network_module/http_client.dart';
import '../providers/provider_constant.dart';

class DonationRepository {
  Future<void> setUserToBeAbleToDonate() async {
    final Map<String, String> header = await ApiHeaderHelper.getValue(ApiHeader.authAppFormUrlEncoded);
    final dynamic response = await HTTPClient.instance.postData(ApiPathHelper.getValue(ApiPath.set_user_to_donate), header);
    print(response);
  }

  Future<void> donate(String amount, String cardNumber, {bool isPomoziBa = false}) async {
    final Map<String, String> header = await ApiHeaderHelper.getValue(ApiHeader.authAppFormUrlEncoded);
    Map<String, String> object = <String, String>{};
    object['CardNumber'] = isPomoziBa ? '' : cardNumber;
    object['Amount'] = amount;
    final dynamic response = await HTTPClient.instance.postData(ApiPathHelper.getValue(ApiPath.pomozi_ba_donacija), header, body: object);
    print(response);
  }
}
