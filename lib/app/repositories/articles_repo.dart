import 'package:lamp/app/models/article_model.dart';
import 'package:lamp/app/models/articles_model.dart';

import '../../network_module/api_header.dart';
import '../../network_module/api_path.dart';
import '../../network_module/http_client.dart';

class ArticlesRepository {
  Future<List<ArticlesModel>> getArticles(String page) async {
    List<ArticlesModel> articles;
    final Map<String, String> header = await ApiHeaderHelper.getValue(ApiHeader.authAppJson);
    final dynamic response = await HTTPClient.instance.fetchData(ApiPathHelper.getValue(ApiPath.get_awards, concatValue: page), header);
    final List<dynamic> responseJson = response as List<dynamic>;
    articles = responseJson.map((e) => ArticlesModel.fromJson(e)).toList();
    return articles;
  }

  Future<ArticleModel> getArticleDetails(String id) async {
    final Map<String, String> header = await ApiHeaderHelper.getValue(ApiHeader.authAppJson);
    final dynamic response = await HTTPClient.instance.fetchData(ApiPathHelper.getValue(ApiPath.award_details, concatValue: id), header);
    return ArticleModel.fromJson(response);
  }

  Future<void> buyArticle(int awardID) async {
    Map<String, String> object = <String, String>{};
    object['AwardId'] = awardID.toString();
    final Map<String, String> header = await ApiHeaderHelper.getValue(ApiHeader.authAppFormUrlEncoded);
    final dynamic response = await HTTPClient.instance.postData(ApiPathHelper.getValue(ApiPath.buy_award), header, body: object);
    print('Response buyArticle $response');
  }
}
