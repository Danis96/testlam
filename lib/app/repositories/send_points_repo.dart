import 'package:lamp/app/models/recipient_info_model.dart';

import '../../network_module/api_header.dart';
import '../../network_module/api_path.dart';
import '../../network_module/http_client.dart';

class SendPointsRepository {
  Future<RecipientInfo> getRecipientInfo(String cardNo, String amount) async {
    final Map<String, String> header = await ApiHeaderHelper.getValue(ApiHeader.authAppJson);
    final dynamic response = await HTTPClient.instance.fetchData(
      ApiPathHelper.getValue(ApiPath.get_recipient_info, concatValue: cardNo, secondConcatValue: amount),
      header,
    );
    return RecipientInfo.fromJson(response);
  }

  Future<void> pointsSendingNumber() async {
    final Map<String, String> header = await ApiHeaderHelper.getValue(ApiHeader.authAppJson);
    final dynamic response = await HTTPClient.instance.fetchData(ApiPathHelper.getValue(ApiPath.points_sending_number), header);
    print('object');
  }

  Future<void> sendPoints(String cardNumber, String amount) async {
    Map<String, dynamic> object = <String, dynamic>{};
    object['CardNumber'] = cardNumber;
    object['Amount'] = amount;
    final Map<String, String> header = await ApiHeaderHelper.getValue(ApiHeader.authAppFormUrlEncoded);
    final dynamic response = await HTTPClient.instance.postData(ApiPathHelper.getValue(ApiPath.send_points), header, body: object);
    print('object');
  }
}
