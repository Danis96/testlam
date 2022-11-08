import 'package:lamp/app/models/promo_code_model.dart';

import '../../network_module/api_header.dart';
import '../../network_module/api_path.dart';
import '../../network_module/http_client.dart';

class PromoCodeRepository {
  Future<PromoCodeModel> sendPromoCode(String cardNumber, String articleCode) async {
    Map<String, String> object = <String, String>{};
    object['CardNo'] = cardNumber;
    object['ArticleCode'] = articleCode;
    final Map<String, String> header = await ApiHeaderHelper.getValue(ApiHeader.authAppFormUrlEncoded);
    final dynamic response = await HTTPClient.instance.postData(ApiPathHelper.getValue(ApiPath.send_promo_code), header, body: object);
    return PromoCodeModel.fromJson(response);
  }
}
