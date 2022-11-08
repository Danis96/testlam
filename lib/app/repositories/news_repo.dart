import 'package:lamp/app/models/news_details.dart';
import 'package:lamp/app/models/news_model.dart';

import '../../network_module/api_header.dart';
import '../../network_module/api_path.dart';
import '../../network_module/http_client.dart';

class NewsRepository {
  Future<List<NewsModel>> getNews(String page, String pageSize) async {
    List<NewsModel> _news;
    final Map<String, String> header = await ApiHeaderHelper.getValue(ApiHeader.authAppJson);
    final dynamic response = await HTTPClient.instance.fetchData(
      ApiPathHelper.getValue(ApiPath.get_all_news, concatValue: page, secondConcatValue: pageSize),
      header,
    );
    final List<dynamic> responseJson = response as List<dynamic>;
    _news = responseJson.map((e) => NewsModel.fromJson(e)).toList();
    return _news;
  }

  Future<NewsDetailsModel> getNewsDetails(int newsId) async {
    final Map<String, String> header = await ApiHeaderHelper.getValue(ApiHeader.authAppJson);
    final dynamic response = await HTTPClient.instance.fetchData(
      ApiPathHelper.getValue(ApiPath.news_by_id, concatValue: newsId.toString()),
      header,
    );
    NewsDetailsModel newsDetailsModel = NewsDetailsModel();
    if (response != null) {
      newsDetailsModel = NewsDetailsModel.fromJson(response);
    }
    return newsDetailsModel;
  }
}
