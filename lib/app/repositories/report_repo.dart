import 'package:lamp/app/models/report_model.dart';

import '../../network_module/api_header.dart';
import '../../network_module/api_path.dart';
import '../../network_module/http_client.dart';

class ReportRepository {
  Future<List<ReportModel>> getUserPurchaseReports(String monthNumber, String yearNumber) async {
    List<ReportModel> reports;
    final Map<String, String> header = await ApiHeaderHelper.getValue(ApiHeader.authAppJson);
    final dynamic response = await HTTPClient.instance.fetchData(
        ApiPathHelper.getValue(ApiPath.get_user_purchase_reports, concatValue: monthNumber, secondConcatValue: yearNumber, thirdConcatValue: '0'),
        header);
    final List<dynamic> responseJson = response as List<dynamic>;
    reports = responseJson.map((e) => ReportModel.fromJson(e)).toList();
    return reports;
  }
}
